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
wait.until{driver.find_element(:xpath, "//ul[@class='collection locations']/li")}
sleep 5
client.btnEditSecondLocation.click
puts "Login Successfully"
sleep 5

#TEST CASES
#TC1
class TestCases
    def initialize(driver,wait,location)
        @location = location
        @driver = driver
        @wait = wait
    end
    def runTC7()
        puts "***\nTC7: Starting..."
        @location.btnSettingsLastNavParentPage.click
        @location.tabImportLayout.click
        sleep 5
        @location.dropdownOneImportLayout.click
        @location.dropdownOneImportLayoutFirstItem.click
        sleep 5
        @location.dropdownTwoPageImportLayout.click
        @location.dropdownTwoPageImportLayoutFirstItem.click
        @location.btnImportLayout.click
        puts "TC7: Importing Page Layout from the same CMS"
        @location.btnModalConfirm.click
        @wait.until{@location.popUpSuccess}
        puts "TC7: Success Popup Shown"
        @location.checkImporting(true)
        (@location.importingPageStatus.text.include?('Importing Layout...')) ? (puts "TC7: Page is importing Successfully") : (puts "TC7 ERROR: Page is not importing!")
        @location.checkImporting(true)
        puts "TC7: Page Imported Successfully"
        puts "TC7: Complete!"
        @location.refreshAndNextTC()
        @location.refreshAndNextTC()
    end
end

testCase = TestCases.new(driver,wait,location)
testCase.runTC7()