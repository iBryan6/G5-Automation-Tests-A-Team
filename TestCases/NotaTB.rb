require "rubygems"
require "webdrivers"
require_relative "../PageObjects/Common/Auth.rb"
require_relative "../PageObjects/Client/Clients.rb"
require_relative "../PageObjects/Location/LocationPages.rb"

#CHANGEABLE VARIABLES
##CLIENT AND LOCATION
@url = 'https://content-management-system-content-prime.g5devops.com/clients/g5-c-5g1te7c7n-byron/websites'
@locationName = 'BRYAN TESTBED'
@remoteClient = 'A1 U Store It'
##TEST CASE PROPERTIES
@newPageName = 'New Page Test'
@pageNameNewValue = 'New Page Name'
@pageTitleNewValue = 'New Page Title'
@pageDescNewValue = 'New Page Description'

#SETUP
driver = Selenium::WebDriver.for :chrome
wait = Selenium::WebDriver::Wait.new(:timeout => 30)
auth = LoginPage.new(driver)
location = LocationPages.new(driver,wait)
client = ClientPage.new(driver,wait)
driver.manage.window.maximize

#LOGIN PAGE
auth.goToPage(@url)
auth.typeEmail
auth.typePassword
auth.clickSubmit
wait.until{driver.find_element(:xpath, "//ul[@class='collection locations']/li")}
puts "Login Successfully"

#CLIENT LOCATION LIST
puts "Starting Basic Functionalities"
client.btnEditSelectedLoc(@locationName).click
sleep 5

class TestCases
    def initialize(driver,wait,location,client)
        @location = location
        @driver = driver
        @wait = wait
        @client = client
    end
    def runTC12(remoteClient, newPageName, url, locationName)

    end
end

testCase = TestCases.new(driver,wait,location,client)