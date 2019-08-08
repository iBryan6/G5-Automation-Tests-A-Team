 # This class will show all the locators and methods of this Page
require "rubygems"
require "webdrivers"

class LocationPages
    def initialize(driver)
        @driver = driver
    end
    def btnCreateNewPage
        return @driver.find_element(:xpath, "//div[@class='anchor-actions']/span/i")
    end
    def inputNewPageName
        return @driver.find_element(:xpath, "//ul[@class='collection pages z-depth-1 nav ember-view']/li/div/div[2]/div/div/input")
    end
    def btnSave
        return @driver.find_element(:xpath, "//div/button")
    end
    def popUpSuccess
        return @driver.find_element(:xpath, "//div[@class='toast alert-box success active ember-view']")
    end
end