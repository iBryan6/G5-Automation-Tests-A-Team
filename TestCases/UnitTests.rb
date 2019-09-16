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
driver.manage.delete_all_cookies

#LOGIN PAGE
auth.goToPage(@url)
auth.typeEmail
auth.autoPassword
wait.until{driver.find_element(:xpath, "//ul[@class='collection locations']/li")}
puts "Login Successfully"

#CLIENT LOCATION LIST
puts "Starting Basic Functionalities"
client.btnEditSelectedLoc(@locationName).click
sleep 5

#TEST CASES
class TestCases
    def initialize(driver,wait,location,client)
        @location = location
        @driver = driver
        @wait = wait
        @client = client
    end
    def runTC13(remoteClient, newPageName, url, locationName)
        puts "***\nTC13: Starting to add Asset via IFU..."
        @location.goToPage(url)
        @client.btnEditSelectedLoc(locationName).click
        sleep 5
        @driver.action.move_to(@location.sideNav).perform
        @location.sideNavIFU.click
        sleep 5
        @driver.action.move_to(@location.btnUploadNewFilesIFU).perform
        @location.btnUploadNewFilesIFU.click
        sleep 10
        @driver.find_element(:xpath, "//div[@class='upload_button_holder']/a").click
        @location.btnSelectFilesIFU.send_keys("C:/Users/bryan.argandona/Downloads/ImageTest.jpg")

        sleep 15
    end
end

testCase = TestCases.new(driver,wait,location,client)
testCase.runTC13(@remoteClient, @newPageName, @url, @locationName)

driver.quit