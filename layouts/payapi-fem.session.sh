# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/keep-coding/web-dev/frontend-mentor/payapi-fem"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "payapi-fem"; then

  # Create a new window inline within session layout definition.
    new_window "neovim"
    split_v 10
    run_cmd "pnpm i && pnpm dev" # use the package manager of your choice
    split_h 60
    run_cmd "zsh"
    select_pane 0
    run_cmd "nvim ."

  # Load a defined window layout.
  #load_window "example"

  # Select the default active window on session creation.
  #select_window 1

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
