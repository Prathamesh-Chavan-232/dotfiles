#!/bin/bash

# Install the required dependencies (assuming you have Chrome, Python, and pip installed)
# You may need to install 'chromedriver' separately if it's not already installed.

# Start Chrome with the specified profile and open the Chrome Sync settings page
chromium-browser --user-data-dir="$CHROME_USER_DATA_DIR" --profile-directory="$PROFILE_NAME" chrome://settings/syncSetup

