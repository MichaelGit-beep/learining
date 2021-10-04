from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import time

options = Options()
options.headless = True 
# , options=options
URL = ""
driver = webdriver.Chrome("S:\\chromedriver.exe")
driver.get(URL)
user = driver.find_element_by_id("username")
password = driver.find_element_by_id("password")
login_button = driver.find_element_by_css_selector(".login-btn")

user.send_keys("")
password.send_keys("")
login_button.click()
time.sleep(5)
case = driver.find_element_by_xpath("/html/body/my-app/div/ng-component/ng-component/div/div/div/case-item[2]/div/div[1]")
case.click()
time.sleep(5)
plays = driver.find_elements_by_class_name("alert-clickable-thumb")
count = 5
for play in plays:
    if count:
        play.click()
        time.sleep(4)
        count -= 1

time.sleep(5)


