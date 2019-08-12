require "rubygems"
require "webdrivers"
require_relative "../PageObjects/Common/Auth.rb"
require_relative "../PageObjects/Client/Clients.rb"
require_relative "../PageObjects/Location/LocationPages.rb"

#CHANGEABLE VARIABLES
@url = 'https://g5-cms-5hq9qn3wg-javier-and-da.herokuapp.com/'
@newPageName = 'New Page Test'
@descNewValue = 'New Page Description'

#SETUP
puts "Starting Basic Functionalities"
wait = Selenium::WebDriver::Wait.new(:timeout => 15)
driver = Selenium::WebDriver.for :chrome
driver.manage.window.maximize

#LOGIN PAGE
auth = LoginPage.new(driver)
auth.goToPage(@url)
auth.typeEmail
auth.typePassword
auth.clickSubmit

#CLIENT LOCATION LIST
client = ClientPage.new(driver)
client.btnEditFirstLocation.click
puts "Login Successfully"
sleep 5

#LOCATIONS PAGES
#TC1
puts "***\nTC1: Starting..."
location = LocationPages.new(driver)
location.btnCreateNewPage.click
location.inputNewPageName.send_keys(@newPageName)
location.btnSave.click
puts "TC1: Adding New Page"
wait.until{location.popUpSuccess}
puts "TC1: Success Popup Shown"
driver.navigate.refresh
wait.until {/New Page Test/.match(driver.page_source)} ? (puts "TC1: New Page Test Added Successfully") : (puts "TC1: New Page Test Wasn't Found!")
puts "TC1: Complete!"
sleep 5

#TC2
puts "***\nTC2: Starting..."
location.btnSettingsLastNavPage.click
location.inputDescriptionPage.clear
location.inputDescriptionPage.send_keys(@descNewValue)
location.btnSave.click
puts "TC2: Changing Page Description"
wait.until{location.popUpSuccess}
puts "TC2: Success Popup Shown"
location.btnSettingsLastNavPage.click
@descriptionValue = location.inputDescriptionPage.attribute('value')
(@descriptionValue == @descNewValue) ? (puts "TC2: Description changed successfully") : (puts "TC2: Description wasn't changed!!")
puts "TC2: Complete!"
sleep 5

#TC3


driver.quit 



