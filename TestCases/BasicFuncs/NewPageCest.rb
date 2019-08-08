require "rubygems"
require "webdrivers"
require_relative "../../PageObjects/Common/Auth.rb"
require_relative "../../PageObjects/Client/Clients.rb"
require_relative "../../PageObjects/Location/LocationPages.rb"

#GO TO THIS PAGE
puts "Starting to Add New Page"
wait = Selenium::WebDriver::Wait.new(:timeout => 15)
driver = Selenium::WebDriver.for :chrome
driver.manage.window.maximize

#LOGIN PAGE
auth = LoginPage.new(driver)
auth.goToPage('https://g5-cms-5hq9qn3wg-javier-and-da.herokuapp.com/')
auth.typeEmail
auth.typePassword
auth.clickSubmit

#CLIENT LOCATION LIST
client = ClientPage.new(driver)
client.btnEditFirstLocation.click
puts "Login Successfully"
sleep 5

#LOCATIONS PAGES
location = LocationPages.new(driver)
location.btnCreateNewPage.click
location.inputNewPageName.send_keys("New Page Test")
location.btnSave.click
wait.until{location.popUpSuccess}
driver.navigate.refresh
wait.until {/New Page Test/.match(driver.page_source)} ? (puts "New Page Test Added Successfully") : (puts "New Page Test Wasn't Found!")
puts "TEST 1: FINISHED"

driver.quit 



