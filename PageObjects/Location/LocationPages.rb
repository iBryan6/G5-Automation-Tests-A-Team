 # This class will show all the locators and methods of this Page
require "rubygems"
require "webdrivers"

class LocationPages
    #CONSTRUCTOR
    def initialize(driver)
        @driver = driver
    end

    #NAVIGATION PAGES
    def pageTitleFirstChild
        return @driver.find_element(:xpath, "//li/ul/li/div/div/div/div[2]/span")
    end
    def pageTitleLastParent
        return @driver.find_element(:xpath, "//ul[@class='collection pages z-depth-1 nav ember-view']/li[last()]/div/div/div/div[2]/span")
    end

    #INPUTS
    def inputPageName
        return @driver.find_element(:xpath, "//ul[@class='collection pages z-depth-1 nav ember-view']/li/div/div[2]/div/div/input")
    end
    def inputPageTitle
        return @driver.find_element(:xpath, "//ul[@class='collection pages z-depth-1 nav ember-view']/li/div/div[2]/div/div[2]/input")
    end
    def inputPageDescription
        return @driver.find_element(:xpath, "//ul[@class='collection pages z-depth-1 nav ember-view']/li/div/div[2]/div/div[3]/input")
    end

    #BUTTONS
    def btnCreateNewPage
        return @driver.find_element(:xpath, "//div[@class='anchor-actions']/span/i")
    end
    def btnSave
        return @driver.find_element(:xpath, "//div/button")
    end
    def btnSettingsLastNavPage
        sleep 5
        return @driver.find_element(:xpath, "//ul[@class='collection pages z-depth-1 nav ember-view']/li[last()]/div/div/div/div[2]/span[2]/a")
    end
    def btnSettingsFirstChildPage(pageNameNewValue)
        sleep 5
        return @driver.find_element(:xpath, "//span[.='#{pageNameNewValue}']/following-sibling::span/a[' Settings ']")
    end
    
    #DROPDOWNS
    def dropdownParentChildPage
        return @driver.find_element(:xpath, "//*[@class='input-field md-select ember-view']/div/input")
    end
    def dropdownParentChildPageItem
        return @driver.find_element(:xpath, "//div/div/div/ul/li[3]/span")
    end
    def dropdownParentChildPageNone
        return @driver.find_element(:xpath, "//div/div/div/ul/li[2]/span")
    end

    #POPUPS
    def popUpSuccess
        return @driver.find_element(:xpath, "//div[@class='toast alert-box success active ember-view']")
    end
end