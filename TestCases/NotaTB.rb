require "rubygems"
require "webdrivers"
require_relative "../PageObjects/Common/Auth.rb"
require_relative "../PageObjects/Client/Clients.rb"
require_relative "../PageObjects/Location/LocationPages.rb"

#CHANGEABLE VARIABLES
@url = 'https://g5-cms-5hq9qn3wg-javier-and-da.herokuapp.com/'
@newPageName = 'New Page Test'
@pageNameNewValue = 'New Page Name'
@pageTitleNewValue = 'New Page Title'
@pageDescNewValue = 'New Page Description'

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
wait.until{client.btnEditFirstLocation}
client.btnEditFirstLocation.click
puts "Login Successfully"
sleep 5
location = LocationPages.new(driver)

#TESTS
puts "***\nTC7: Starting..."
location.btnSettingsLastNavParentPage.click
location.tabImportLayout.click
sleep 5
location.dropdownLocationImportLayout.click
location.dropdownLocationImportLayoutFirstItem.click
sleep 5
location.dropdownLocationPageImportLayout.click
location.dropdownLocationPageImportLayoutFirstItem.click
sleep 5
location.btnImportLayout.click
puts "TC7: Importing Page Layout from the same CMS"
sleep 3
location.btnModalConfirm.click
wait.until{location.popUpSuccess}
puts "TC7: Success Popup Shown"
driver.navigate.refresh
sleep 5
(location.importingPageStatusLastNavPage.text.include?('Importing Layout...')) ? (puts "TC7: Page is importing Successfully") : (puts "TC7 ERROR: Page is not importing!")
while (location.importingPageStatusLastNavPage.text.include?('Importing Layout...') == true) do
    driver.navigate.refresh
end