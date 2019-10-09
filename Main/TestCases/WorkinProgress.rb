require "rubygems"
require "webdrivers"
require_relative "../PageObjects/Common/Auth.rb"
require_relative "../PageObjects/Client/Clients.rb"
require_relative "../PageObjects/Location/LocationPages.rb"

#CHANGEABLE VARIABLES
##CLIENT AND LOCATION
@url = 'https://cms.g5marketingcloud.com/clients/g5-c-5g1te7c7n-byron/websites'
@remoteClient = 'A1 U Store It'
@locationName = 'BRYAN TESTBED'

#TEST CASES
class TestCases
    def initialize(url, locationName)
        #INIT
        @driver = Selenium::WebDriver.for :chrome
        @wait = Selenium::WebDriver::Wait.new(:timeout => 30)
        @auth = LoginPage.new(@driver)
        @location = LocationPages.new(@driver, @wait)
        @client = ClientPage.new(@driver, @wait)
        #VARIABLES
        ##TEST CASE PROPERTIES
        @newPageName = 'New Page Test'
        @pageNameNewValue = 'New Page Name'
        @pageTitleNewValue = 'New Page Title'
        @pageDescNewValue = 'New Page Description'
        #BROWSER SETTINGS
        @driver.manage.window.maximize
        @driver.manage.delete_all_cookies
        #LOGIN
        @auth.goToPage(url)
        @auth.typeEmail()
        @auth.typePassword()
        @wait.until{@driver.find_element(:xpath, "//ul[@class='collection locations']/li")}
        puts "***\nLogin Successfully, starting Basic Functionalities"
        #START
        @client.btnEditSelectedLoc(locationName).click
        sleep 5
    end
    def runTC7
        puts "***\nTC7: Starting to import page layout from same CMS..."
        @location.btnSettings(@pageNameNewValue).click
        @location.tabImportLayout.click
        sleep 5
        @location.dropdownSelectLocation.click
        sleep 5
        @location.dropdownSelectLocationFirstItem.click
        sleep 5
        @location.dropdownSelectPage.click
        sleep 5
        @location.dropdownSelectPageFirstItem.click
        @location.btnImportLayout.click
        puts "TC7: Importing Page Layout from the same CMS"
        @location.btnModalConfirm.click
        @wait.until{@location.popUpSuccess}
        puts "TC7: Success Popup Shown"
        (@location.pageStatus(@pageNameNewValue).text.include?('Importing Layout...')) ? (puts "TC7: Page is importing") : (puts "TC7 ERROR: Page is not importing!")
        @location.checkImporting(true, @pageNameNewValue)
        puts "TC7: Page Imported Successfully"
        puts "TC7: Complete!"
        @location.refreshAndNextTC()
    end
end

basicTestSuite = TestCases.new(@url, @locationName)
basicTestSuite.runTC7()

=begin

basicTestSuite.runTC8(@remoteClient)
basicTestSuite.runTC9(@url, @locationName)
basicTestSuite.runTC10(@url, @remoteClient, @locationName)
basicTestSuite.runTC11(@url, @remoteClient, @locationName)
=end