#!/bin/bash

# Function to create directories and subdirectories
create_directories() {
    mkdir -p "$1" || exit
    echo "Created directory: $1"
}

# Function to clone GitHub repositories
clone_repo() {
    cd "$1" || exit
    shift
    while [[ $# -gt 0 ]]; do
        git clone "$1"
        shift
    done
}

# Main function to create directory structure and clone repositories
setup_workspaces() {
    # Create coding-practice directory and clone repos
    cd ""
    mkdir test-dir
    cd "./test-dir" || exit

    create_directories "coding-practice" "dsa-practice" "problem-solving"
    # Create app-dev directory and subdirectories
    create_directories "app-dev" "work" "gigs" "practice" "projects"

    # Clone repository in app-dev/gigs
    create_directories "app-dev/gigs" "first_india_plus"
    clone_repo "app-dev/gigs/first_india_plus" "git@github.com:Prathamesh-Chavan-232/first_india_plus.git"

    # Create app-dev directory and subdirectories
    create_directories "web-dev" "work" "gigs" "practice" "projects"

    # Clone repositories in app-dev/work
    create_directories "web-dev/gigs" "first-india-plus-website"
    clone_repo "web-dev/gigs/first-india-plus-website" "git@github.com:Prathamesh-Chavan-232/first-india-plus-website.git"

    # Clone repositories in app-dev/work
    create_directories "web-dev/projects" "notes-app-tsx"
    clone_repo "web-dev/gigs/notes-app-tsx" "git@github.com:Prathamesh-Chavan-232/notes-app-tsx.git"
}

# Call the main function
setup_workspaces
