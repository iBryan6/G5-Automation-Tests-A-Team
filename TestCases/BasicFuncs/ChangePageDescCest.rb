require "rubygems"
require "webdrivers"
require_relative "../../PageObjects/Common/Auth.rb"
require_relative "../../PageObjects/Client/Clients.rb"
require_relative "../../PageObjects/Location/LocationPages.rb"

#CHANGEABLE VARIABLES
@url = 'https://g5-cms-5hq9qn3wg-javier-and-da.herokuapp.com/'
@descNewValue = 'New Page Description'

#SETUP
puts "Starting to Change Page Description"
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
location = LocationPages.new(driver)
location.btnSettingsLastNavPage.click
location.inputDescriptionPage.clear
location.inputDescriptionPage.send_keys(@descNewValue)
location.btnSave.click
wait.until{location.popUpSuccess}
puts "Success Popup Shown"
location.btnSettingsLastNavPage.click
@descriptionValue = location.inputDescriptionPage.attribute('value')
(@descriptionValue == @descNewValue) ? (puts "Description changed successfully!") : (puts "Description wasn't changed!!")
sleep 5