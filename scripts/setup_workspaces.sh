#!/bin/bash

# Function to create directories and subdirectories
create_directories() {
    mkdir -p "$1"
    cd "$1" || exit
    shift
    while [[ $# -gt 0 ]]; do
        mkdir -p "$1"
        shift
    done
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
    create_directories "coding-practice" "dsa-practice" "problem-solving"
    clone_repo "coding-practice/dsa-practice" "git@github.com:Prathamesh-Chavan-232/dsa-practice.git"
    clone_repo "coding-practice/problem-solving" "git@github.com:Prathamesh-Chavan-232/problem-solving.git"

    # Create app-dev directory and subdirectories
    create_directories "app-dev" "work" "gigs" "practice" "projects"

    # Clone repositories in app-dev/work
    create_directories "app-dev/work" "dementia-app"
    clone_repo "app-dev/work/dementia-app" "git@github.com:Manastik-Tech/dementia-app.git"

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

