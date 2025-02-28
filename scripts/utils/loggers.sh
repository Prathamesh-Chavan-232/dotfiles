#!/bin/bash

# Loggers
# Define colors
RED='\033[0;31m'        # Red color
GREEN='\033[0;32m'      # Green color
LIGHT_PURPLE='\e[1;35m' # Light Purple Color
NC='\033[0m'            # No Color

print_header() {
	local color=$1
	local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
	echo ""
	echo -e "${color}==== $2 [$timestamp] ====${NC}"
	echo ""
}

print_subheader() {
	local color=$1
	echo -e "${color}$2${NC}"
}

print_log() {
	local color=$1
	local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
	echo ""
	echo -e "${color}$2                              [$timestamp]${NC}"
}


