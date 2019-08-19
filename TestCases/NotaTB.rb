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
@remoteClient = 'A1 U Store It'

#SETUP
driver = Selenium::WebDriver.for :chrome
wait = Selenium::WebDriver::Wait.new(:timeout => 20)
auth = LoginPage.new(driver)
location = LocationPages.new(driver,wait)
client = ClientPage.new(driver,wait)
driver.manage.window.maximize

#LOGIN PAGE
auth.goToPage(@url)
auth.typeEmail
auth.typePassword
auth.clickSubmit

#CLIENT LOCATION LIST
puts "Starting Basic Functionalities"
while (client.is_element_present(:css, "spinner-wrapper") == true) do
    sleep 5
    puts "test"
end
wait.until{driver.find_element(:xpath, "//ul[@class='collection locations']/li")}
puts "Login Successfully"
sleep 5

#TESTS
puts "***\nTC10: Starting..."
client.tabCopyWebsites.click
client.checkboxRemoteCMS.click
sleep 5
client.dropdownOneCopyWebsite.click
client.dropdownContainsRemoteClient(@remoteClient).click
sleep 5
client.dropdownTwoCopyWebsite.click
client.dropdownTwoCopyWebsiteFirstItem.click
sleep 5
client.checkboxTargetFirstWebsite.click
client.btnConfirmCopyWebsite.click
client.btnModalConfirm.click
puts "TC10: Copying entire Remote Website to Local Website"
wait.until{client.popUpSuccess}
puts "TC10: Success Popup Shown"
client.checkImporting(false)
(client.statusWebsite.text.include?('Updating')) ? (puts "TC10: Page is being copied") : (puts "TC10 ERROR: Page is not being copied!")
client.checkImporting(true)
puts "TC10: Page Copied Successfully"
puts "TC10: Complete!"
client.refreshAndWait