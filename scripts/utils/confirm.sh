#!/bin/bash

# Confirmation utility for interactive prompts
confirm() {
    local message="$1"
    echo ""
    echo -n -e "${YELLOW}${message} (y/n): ${NC}"
    read -r response
    response_lower=$(echo "$response" | tr '[:upper:]' '[:lower:]')
    [[ "$response_lower" == "y" || "$response_lower" == "yes" ]]
}