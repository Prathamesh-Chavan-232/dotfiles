#!/bin/bash

setup_github_keys() {
  # Add github account SSH Keys
  print_header "${GREEN}" "Adding Github Accounts SSH keys"

  # Personal account
  if [ ! -f ~/.ssh/id_github_personal ]; then
    print_log "${GREEN}" "Creating SSH key for personal account..."
    ssh-keygen -t ed25519 -f ~/.ssh/id_github_personal
    ssh-add ~/.ssh/id_github_personal
    print_log "${GREEN}" "Personal account SSH key created successfully."
  else
    print_log "${YELLOW}" "Personal account SSH key already exists."
  fi

  # Adding config file
  print_subheader "${GREEN}" "Adding SSH keys config"
  if [ ! -f ~/.ssh/config ]; then
    cp github-ssh/config ~/.ssh/
  else
    print_log "${YELLOW}" "A Config file already exists."
  fi
  print_subheader "${GREEN}" "SSH keys setup completed."
}
