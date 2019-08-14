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
client = ClientPage.new(driver,wait)
sleep 5
wait.until{client.btnEditFirstLocation}
client.btnEditFirstLocation.click
puts "Login Successfully"
sleep 5
location = LocationPages.new(driver,wait)

#TESTS
puts "***\nTC9: Starting..."
driver.navigate.to(@url)
sleep 5
client.tabCopyWebsites.click
client.dropdownOneCopyWebsite.click
client.dropdownOneCopyWebsiteFirstItem.click
client.checkboxTargetFirstWebsite.click
client.btnConfirmCopyWebsite.click
client.btnModalConfirm.click
puts "TC9: Copying entire Website to Local Website"
wait.until{client.popUpSuccess}
puts "TC9: Success Popup Shown"
while (client.is_element_present(:css, "span.pulsate") == false) do
    driver.navigate.refresh
    sleep 5
end
(client.statusWebsite.text.include?('Updating')) ? (puts "TC9: Page is being copied") : (puts "TC9 ERROR: Page is not being copied!")
while (client.is_element_present(:css, "span.pulsate") == true) do
    driver.navigate.refresh
    sleep 5
end
puts "TC9: Page Copied Successfully"
puts "TC9: Complete!"
client.refreshAndWait