require "rubygems"
require "webdrivers"
require_relative "../PageObjects/Common/Auth.rb"
require_relative "../PageObjects/Client/Clients.rb"
require_relative "../PageObjects/Location/LocationPages.rb"

#CHANGEABLE VARIABLES
@cms = 'https://g5-cms-5hq9qn3wg-javier-and-da.herokuapp.com/'
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
auth.goToPage(@cms)
auth.typeEmail
auth.typePassword
auth.clickSubmit

#TESTS
puts "***\nTC11: Starting to check if styles copied successfully"
@remoteCmsURL = client.getG5HubClientURL(@remoteClient)
driver.navigate.to(@remoteCmsURL)
sleep 5
client.btnEditFirstLocation.click
wait.until{driver.find_element(:xpath, "//i[@class='fa fa-pencil ember-view']")}
driver.action.move_to(driver.find_element(:xpath, "//i[@class='fa fa-pencil ember-view']/following-sibling::span")).perform
sleep 3
location.sideMenuLayoutWidgets.click
puts "clicked Layout Widgets"
sleep 3
wait.until{driver.find_element(:xpath, "//p/div/div/div[2]/div/div/div")}
@remoteLocPrimaryColor = location.baseColorPrimary.attribute("style")
puts @remoteLocPrimaryColor
@RemoteLocSecondaryColor = location.baseColorSecondary.attribute("style")
@RemoteLocTertiaryColor = location.baseColorTertiary.attribute("style")
