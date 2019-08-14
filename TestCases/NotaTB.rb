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
wait = Selenium::WebDriver::Wait.new(:timeout => 20)
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
sleep 5
wait.until{client.btnEditFirstLocation}
client.btnEditFirstLocation.click
puts "Login Successfully"
sleep 5
location = LocationPages.new(driver,wait)

#TESTS
puts "***\nTC8: Starting..."
location.btnSettingsLastNavParentPage.click
location.tabImportLayout.click
location.checkboxRemoteCMS.click
sleep 5
location.dropdownOneImportLayout.click
location.dropdownOneImportLayoutFirstItem.click
sleep 5
location.dropdownTwoPageImportLayout.click
location.dropdownTwoPageImportLayoutFirstItem.click
sleep 5
location.dropdownThreePageImportLayout.click
location.dropdownThreePageImportLayoutFirstItem.click
location.btnImportLayout.click
puts "TC8: Importing Page Layout from the a Remote CMS"
location.btnModalConfirm.click
wait.until{location.popUpSuccess}
puts "TC8: Success Popup Shown"
location.refreshAndWait()
(location.importingPageStatusLastNavPage.text.include?('Importing Layout...')) ? (puts "TC8: Page is importing Successfully") : (puts "TC8 ERROR: Page is not importing!")
while (location.is_element_present(:css, "span.pulsate") == true) do
    driver.navigate.refresh
end
puts "TC8: Page Imported Successfully"
puts "TC8: Complete!"
location.refreshAndWait()