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

#TEST CASES
class TestCases
    def initialize(url, locationName)
        @driver = Selenium::WebDriver.for :chrome
        @wait = Selenium::WebDriver::Wait.new(:timeout => 30)
        @auth = LoginPage.new(@driver)
        @location = LocationPages.new(@driver, @wait)
        @client = ClientPage.new(@driver, @wait)
        @driver.manage.window.maximize
        @driver.manage.delete_all_cookies
        @auth.goToPage(url)
        @auth.typeEmail
        @auth.typePassword
        @wait.until{@driver.find_element(:xpath, "//ul[@class='collection locations']/li")}
        puts "Login Successfully"
        puts "Starting Basic Functionalities"
        @client.btnEditSelectedLoc(locationName).click
    end
    def runTC5(pageNameNewValue)
        puts "***\nTC5: Starting to switch between child/parent page..."
        @location.btnSettings(pageNameNewValue).click
        @location.dropdownParentChildPage.click
        @location.dropdownParentChildPageItem.click
        @location.btnSave.click
        puts "TC5: Changing to a Child Page"
        @wait.until{@location.popUpSuccess}
        puts "TC5: Success Popup Shown"
        @location.refreshAndWait()
        sleep 3
        (@location.pageTitleFirstChild.text.include?(pageNameNewValue)) ? (puts "TC5: Changed to a Child Page Successfully") : (puts "TC5 ERROR: Page wasn't changed to a Child Page")
        sleep 5
        @location.btnSettings(pageNameNewValue).click
        @location.dropdownParentChildPage.click
        @location.dropdownParentChildPageNone.click
        @location.btnSave.click
        puts "TC5: Changing to a Parent Page"
        @wait.until{@location.popUpSuccess}
        puts "TC5: Success Popup Shown"
        @location.refreshAndWait()
        (@location.pageTitleLastParent.text.include?(pageNameNewValue)) ? (puts "TC5: Changed to a Parent Page Successfully") : (puts "TC5 ERROR: Page wasn't changed to a Parent Page")
        puts "TC5: Complete!"
        @location.refreshAndNextTC()
    end
end

testCase = TestCases.new(@url, @locationName)
testCase.runTC5(@pageNameNewValue)