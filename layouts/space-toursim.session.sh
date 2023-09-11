#!/bin/zsh

# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
# echo "Select project directory: "
# read working_dir
session_root "/home/falconcodes/keep-coding/web-dev/projects/space-tourism-fem/"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "space-tourism"; then

  # Create a new window inline within session layout definition.
  new_window "neovim"
  split_v 10
  run_cmd "pnpm i && pnpm dev"
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
