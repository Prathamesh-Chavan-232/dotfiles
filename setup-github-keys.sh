# Loggers
# Define colors
RED='\033[0;31m'   # Red color
GREEN='\033[0;32m' # Green color
YELLOW='\033[0;33m'
LIGHT_PURPLE='\e[1;35m' # Light Purple Color
NC='\033[0m'            # No Color

print_header() {
	local color=$1
	local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
	echo ""
	echo -e "${color}==== $2 [$timestamp] ====${NC}"
	echo ""
}
print_log() {
	local color=$1
	local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
	echo ""
	echo -e "${color}$2                              [$timestamp]${NC}"
}
print_subheader() {
	local color=$1
	echo -e "${color}$2${NC}"
}

# Add github account SSH Keys
print_header "${GREEN}" "Adding Github Accounts SSH keys"
# Personal account
if [ ! -f ~/.ssh/Prathamesh-Chavan-232 ]; then
	print_log "${GREEN}" "Creating SSH key for personal account..."
	ssh-keygen -t ed25519 -C "prathamesh.chavanpsc2018@gmail.com" -f ~/.ssh/Prathamesh-Chavan-232
	ssh-add ~/.ssh/Prathamesh-Chavan-232
	print_log "${GREEN}" "Personal account SSH key created successfully."
else
	print_log "${YELLOW}" "Personal account SSH key already exists."
fi

# Work account
if [ ! -f ~/.ssh/Prathamesh-Chavan-Noovosoft ]; then
	print_log "${GREEN}" "Creating SSH key for work account..."
	ssh-keygen -t ed25519 -C "prathamesh.chavan@noovosoft.com" -f ~/.ssh/Prathamesh-Chavan-Noovosoft
	ssh-add ~/.ssh/Prathamesh-Chavan-Noovosoft
	print_log "${GREEN}" "Work account SSH key created successfully."
else
	print_log "${YELLOW}" "Work account SSH key already exists."
fi

# Adding config file
print_subheader "${GREEN}" "Adding SSH keys config"
if [ ! -f ~/.ssh/config ]; then
	print_log "${GREEN}" "Adding github SSH keys config"
	cp github-ssh/config ~/.ssh/
else
	print_log "${YELLOW}" "A Config file already exists."
fi

print_log "${GREEN}" "SSH keys setup completed."

