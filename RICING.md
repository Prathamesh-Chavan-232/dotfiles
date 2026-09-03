# Fedora Dev Environment + Ricing Runbook

Order matters: get a rock-solid, stow-managed dev base working first, snapshot it, *then* rice. The rices touch `~/.config/hypr` (and X11 configs); your nvim/tmux/zsh/wezterm live outside that and you own them via stow — keep it that way at every step.

First, confirm what you're on (all guidance below assumes dnf5, i.e. Fedora 41+):

```bash
cat /etc/fedora-release      # e.g. "Fedora release 44 (...)"
dnf --version                # confirms dnf5
lspci | grep -Ei 'vga|3d'    # note if NVIDIA (affects driver + Hyprland session)
```

---

## Phase 0 — Pre-flight (do not skip)

1. **Snapshot tooling.** Fedora is Btrfs by default, so snapshots are cheap. Install one and take a baseline:
   ```bash
   sudo dnf install snapper       # native to Btrfs; or: sudo dnf install timeshift
   ```
   Take a snapshot now, and again before each ricing phase. This is your undo button when a rice installer touches system files.
2. **Third-party repos + base update:**
   ```bash
   sudo dnf install \
     https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
     https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
   sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1
   flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
   sudo dnf upgrade --refresh
   ```
3. **NVIDIA (only if the lspci check showed it):**
   ```bash
   sudo dnf install akmod-nvidia xorg-x11-drv-nvidia-cuda
   # wait a few minutes for akmod to build, then reboot before ricing
   ```

---

## Phase 1 — Dev environment (the "just works" base)

**On a fresh install, do this phase MANUALLY.** This is deliberate: language runtimes and anything with a third-party repo change their install method often, and doing it by hand is how you catch the change — then you update the script to match. The refactored `install.sh` is **not** a fresh-install autopilot; it's for quickly re-provisioning a throwaway user or VM *after* it's been re-validated against this manual run. So: run the commands below by hand now, and treat them as the source of truth the script must mirror.

Rough split of what's safe to script later vs. what stays manual:
- **Plain repo installs** (`sudo dnf install <x>`) — safe to script: git, tmux, zsh, stow, ripgrep, fzf, fd-find, bat, lsd, zoxide, fastfetch, neovim, python3, golang, nodejs24, pnpm, gh, firefox, xclip/wl-clipboard.
- **Always manual** (repo+key, curl|bash, or version managers — verify each time): Docker & WezTerm (repo+key), pyenv / nvm / SDKMAN / rustup (runtimes), anything built from cargo.

**Core tools + shell stack:**
```bash
sudo dnf install git gh @development-tools cmake pkgconf \
  neovim tmux zsh starship wezterm \
  ripgrep fzf fd-find bat lsd zoxide fastfetch stow \
  xclip wl-clipboard
```
- **Neovim** here is 0.12.x from the repo — exactly what your config needs. No bob.

**Languages / runtimes:**
```bash
sudo dnf install nodejs24 pnpm             # nodejs24 bundles npm (nodejs24-npm); pnpm is a separate package. No corepack needed.
sudo dnf install python3 python3-pip python3-virtualenv
# pyenv (optional, for multiple Python versions):
curl -fsSL https://pyenv.run | bash
# Go:
sudo dnf install golang
# Java via SDKMAN (matches your existing setup):
curl -s https://get.sdkman.io | bash
# Rust:
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```
- Skip **nvm** unless a legacy project needs it — repo Node is current.

**Docker:**
```bash
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager addrepo --from-repofile=https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable --now docker
sudo usermod -aG docker "$USER"
# then LOG OUT AND BACK IN (or reboot). `newgrp docker` only affects one subshell — don't rely on it.
```

**Fonts** (Nerd Font for nvim/terminal):
```bash
sudo dnf install fira-code-fonts   # or drop a Nerd Font into ~/.local/share/fonts && fc-cache -fv
```

**Link your dotfiles and verify (do this by hand too, before any rice):**
```bash
cd ~/path/to/dotfiles
./scripts/install.sh --dotfiles --plugins    # or stow packages manually
```
Then verify the base is solid *before* touching any rice:
- `nvim` opens, `vim.pack` installs plugins, LSP attaches, `:checkhealth` is clean.
- `tmux` loads config; prefix+I installs plugins.
- `zsh` is default shell (`chsh -s "$(which zsh)"`, re-login), starship prompt shows, zoxide/fzf work.

**Snapshot again here — this is your "clean dev base" restore point.**

---

## Phase 2 — Decide the ricing shape

You're running three very different things. Settle the roles now:

- **JaKoolit Hyprland** → your **daily driver** (waybar-based, has a real Fedora installer).
- **end-4 / illogical-impulse** → an **evaluation target** in a throwaway user (Quickshell/QML shell — you'll steal *settings and ideas*, not widgets).
- **gh0stzk bspwm** → a **second X11 session** on your main user (coexists cleanly with Hyprland).

Why you can't just merge JaKoolit + end-4: JaKoolit renders its bar/widgets with **waybar**, end-4 with **Quickshell** — different engines. Portable between them: `hyprland.conf` keybinds, window rules, animations, decoration, wallpapers, GTK themes. Not portable: the actual shell/widgets.

---

## Phase 3 — JaKoolit Hyprland (daily driver)

```bash
# snapshot first
git clone --depth=1 https://github.com/JaKooLit/Fedora-Hyprland.git ~/Fedora-Hyprland
cd ~/Fedora-Hyprland
chmod +x install.sh
./install.sh
```
In the whiptail menu: select SDDM (recommended login manager for this), Quickshell overview if offered (COPR-dependent on your Fedora version), zsh **off** (you have your own), and NVIDIA options only if applicable. Reboot, pick the **Hyprland** session at SDDM.

After it's up: re-apply your own dotfiles so your nvim/tmux/zsh win over anything JaKoolit dropped:
```bash
cd ~/path/to/dotfiles && ./scripts/install.sh --dotfiles
```
Live-config lives in `~/.config/hypr/UserConfigs/` and `UserSettings/` — that's where you'll add personal keybinds/rules later.

**Snapshot.**

---

## Phase 4 — Evaluate end-4 in a separate user (safe sandbox)

```bash
sudo useradd -m -G wheel rice-test && sudo passwd rice-test
# log out, log in as rice-test (GDM/SDDM user switch), then in that session:
bash <(curl -s https://ii.clsty.link/get)      # or clone + ./setup install
```
Note end-4's own warning: it's "NOT a system setup script" — it installs the graphical shell, assuming Hyprland/drivers exist. Check the wiki (ii.clsty.link) for the Fedora dependency list, and mind the Hyprland 0.55 note (use the "Pre-Hyprland Luaification" release if your Hyprland is older).

Use it, decide what you like, then **port at the config level** into your JaKoolit user's `~/.config/hypr/UserConfigs/`: keybinds, window rules, animation curves, wallpapers. Do **not** try to copy Quickshell widgets into waybar. When done, you can `sudo userdel -r rice-test`.

---

## Phase 5 — gh0stzk bspwm as a second session (same user, X11)

This coexists with Hyprland — different WM, different config paths, different display protocol. Their `RiceInstaller` is Arch-only, so install the stack manually on Fedora.

**Fedora 44 note:** GNOME 50 dropped its X11 *session* (the `ENABLE_X11_SUPPORT` gdm flag has been off since F42), but the Xorg *server* package is untouched — `@base-x` still installs it, and i3/bspwm/xmonad remain packaged. bspwm runs its own Xorg session via the `.desktop` entry below, independent of GNOME. Consequence specific to 44: there's no GNOME-on-Xorg to fall back to anymore, so **this bspwm session is now your only practical X11 fallback** — worth getting working early, especially on NVIDIA where a Wayland/Hyprland driver hiccup would otherwise leave you with no X11 session to retreat to.

```bash
sudo dnf install @base-x xorg-x11-xinit \
  bspwm sxhkd polybar picom dunst rofi-wayland \
  feh jgmenu xsettingsd playerctl xdotool xclip maim \
  alacritty kitty
# eww and clipcat are usually NOT packaged — build via cargo or find a COPR:
cargo install eww    # (or a COPR); clipcat similarly
```
**rofi gotcha:** don't install X11 `rofi` — it conflicts with the `rofi-wayland` your Hyprland rice uses. `rofi-wayland` runs on X11 too, so keep only that and point gh0stzk's config at `rofi`/`rofi-wayland` accordingly.

Then pull the configs (into your main user), keeping your own shell/tmux/nvim intact:
```bash
git clone --depth=1 https://github.com/gh0stzk/dotfiles.git ~/gh0stzk-dots
# copy ONLY the WM/bar/theme pieces you want, e.g.:
cp -r ~/gh0stzk-dots/config/{bspwm,sxhkd,polybar,picom,eww,rofi} ~/.config/
cp -r ~/gh0stzk-dots/config/bin ~/.local/bin/      # its helper scripts, if present
# DO NOT copy their zsh/tmux/nvim over yours.
```
Add a session entry so your login manager lists bspwm:
```bash
sudo tee /usr/share/xsessions/bspwm.desktop >/dev/null <<'EOF'
[Desktop Entry]
Name=bspwm
Exec=bspwm
Type=Application
EOF
```
Log out, pick **bspwm** at the login screen. Their theme switcher (Super+Alt+... / RiceEditor) works once bspwm is the active session. If a keybind or script assumes an Arch path, fix the path — everything they use has a Fedora equivalent.

To answer your direct question: **yes, two DEs/WMs on one user is fully supported.** Session-specific configs (`~/.config/hypr` vs `~/.config/bspwm`) only load under their own session, so X11 bspwm configs and Wayland Hyprland configs never collide. The only shared surface is shell/tmux/nvim — which you already control via stow.

---

## Phase 6 — Converge

- Daily driver: JaKoolit Hyprland, personalized in `UserConfigs/`.
- gh0stzk bspwm: available as a fallback/light X11 session on the same user (good for the NVIDIA-heavy or low-RAM days — it starts under ~600 MB).
- end-4: gone (evaluated), with its good ideas folded into your Hyprland config.
- Everything shell/editor stays yours via the dotfiles repo, re-`stow`-able on any of them.

Snapshot the final state. From here, day-to-day changes go through your dotfiles repo, not the upstream installers.
