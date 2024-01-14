from selenium import webdriver
import chromedriver_autoinstaller
from selenium.webdriver.common.keys import Keys

CHROME_USER_DATA_DIR = "/usr/bin/google-chrome-stable"
PROFILE_NAME = "Ankit Chutiya"

chromedriver_autoinstaller.install()  # Install or update Chromedriver

chrome_options = webdriver.ChromeOptions()
chrome_options.add_argument(f"--user-data-dir={CHROME_USER_DATA_DIR}")
chrome_options.add_argument(f"--profile-directory={PROFILE_NAME}")

driver = webdriver.Chrome(options=chrome_options)
driver.get("https://accounts.google.com")

email_input = driver.find_element_by_name("identifier")
email_input.send_keys("hulkbusterpowerd@gmail.com")
email_input.send_keys(Keys.RETURN)

# Wait for the password input field to load and then enter the password
password_input = driver.find_element_by_name("password")
password_input.send_keys("Pr@th#2023")
password_input.send_keys(Keys.RETURN)


# Again, please note that automating web browsers can be complex and may require
# adjustments depending on changes in Chrome,the website, or the web automation tools.
