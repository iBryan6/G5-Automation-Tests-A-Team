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