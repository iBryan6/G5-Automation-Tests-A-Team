require "rubygems"
require "webdrivers"
require_relative "../PageObjects/Common/Auth.rb"
require_relative "../PageObjects/Client/Clients.rb"
require_relative "../PageObjects/Location/LocationPages.rb"

#CHANGEABLE VARIABLES
##CLIENT AND LOCATION
@url = 'https://content-management-system-content-prime.g5devops.com/clients/g5-c-5g1te7c7n-byron/websites'
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
        @auth.autoEmail("bryan.argandona-c@getg5.com")
        @auth.autoPassword("6Mishteamo6")
        @wait.until{@driver.find_element(:xpath, "//ul[@class='collection locations']/li")}
        puts "***\nLogin Successfully, starting Basic Functionalities"
        #START
        @client.btnEditSelectedLoc(locationName).click
        sleep 5
    end
end

testSuite = TestCases.new(@url, @locationName)