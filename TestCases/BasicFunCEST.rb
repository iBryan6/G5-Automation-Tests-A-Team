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
client.btnEditFirstLocation.click
puts "Login Successfully"
sleep 5

#TEST CASES
#TC1
puts "***\nTC1: Starting..."
location = LocationPages.new(driver)
location.btnCreateNewPage.click
location.inputPageName.send_keys(@newPageName)
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
location.inputPageName.clear
location.inputPageName.send_keys(@pageNameNewValue)
puts "TC2: Changing Page Name"
location.btnSave.click
wait.until{location.popUpSuccess}
puts "TC2: Success Popup Shown"
location.btnSettingsLastNavPage.click
@nameValue = location.inputPageName.attribute('value')
(@nameValue == @pageNameNewValue) ? (puts "TC2: Name changed successfully") : (puts "TC2: Name wasn't changed!!")
puts "TC2: Complete!"
driver.navigate.refresh
sleep 5

#TC3
puts "***\nTC3: Starting..."
location.btnSettingsLastNavPage.click
location.inputPageTitle.clear
location.inputPageTitle.send_keys(@pageTitleNewValue)
puts "TC3: Changing Page Title"
location.btnSave.click
wait.until{location.popUpSuccess}
puts "TC3: Success Popup Shown"
location.btnSettingsLastNavPage.click
@titleValue = location.inputPageTitle.attribute('value')
(@titleValue == @pageTitleNewValue) ? (puts "TC3: Title changed successfully") : (puts "TC3: Title wasn't changed!!")
puts "TC3: Complete!"
driver.navigate.refresh
sleep 5

#TC4
puts "***\nTC4: Starting..."
location.btnSettingsLastNavPage.click
location.inputPageDescription.clear
location.inputPageDescription.send_keys(@pageDescNewValue)
puts "TC4: Changing Page Description"
location.btnSave.click
wait.until{location.popUpSuccess}
puts "TC4: Success Popup Shown"
location.btnSettingsLastNavPage.click
@descriptionValue = location.inputPageDescription.attribute('value')
(@descriptionValue == @pageDescNewValue) ? (puts "TC4: Description changed successfully") : (puts "TC4: Description wasn't changed!!")
puts "TC4: Complete!"
driver.navigate.refresh
sleep 5

#TC5

driver.quit 



