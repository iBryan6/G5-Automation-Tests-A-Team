 # This class will show all the locators and methods of this Page
require "rubygems"
require "webdrivers"

class ClientPage
    def initialize(driver)
        @driver = driver
    end
    def btnEditFirstLocation
        return @driver.find_element(:xpath, "//ul[2]/li[2]/div/div/div[2]/div[3]/a[@class='btn edit-button ember-view']/span")
    end
end