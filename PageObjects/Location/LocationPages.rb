 # This class will show all the locators and methods of this Page
require "rubygems"
require "webdrivers"

class LocationPages
    #CONSTRUCTOR
    def initialize(driver,wait)
        @driver = driver
        @wait = wait
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

    #TABS
    def tabImportLayout
        return @driver.find_element(:xpath, "//div[2]/div/div/div/ul/li[2]/a")
    end
    def tabExportLayout
        return @driver.find_element(:xpath, "//div[2]/div/div/div/ul/li[3]/a")
    end

    #CHECKBOXES
    def checkboxRemoteCMS
        return @driver.find_element(:xpath, "//div[2]/div/div[2]/div/label")
    end

    #BUTTONS
    def btnCreateNewPage
        return @driver.find_element(:xpath, "//div[@class='anchor-actions']/span/i")
    end
    def btnSave
        return @driver.find_element(:xpath, "//div/button")
    end
    def btnSettingsLastNavParentPage
        sleep 5
        return @driver.find_element(:xpath, "//ul[@class='collection pages z-depth-1 nav ember-view']/li[last()]/div/div/div/div[2]/span[2]/a")
    end
    def btnSettingsFirstNavChildPage(pageNameNewValue)
        sleep 5
        return @driver.find_element(:xpath, "//span[.='#{pageNameNewValue}']/following-sibling::span/a[' Settings ']")
    end
    def btnImportLayout
        sleep 5
        return @driver.find_element(:xpath, "//a[@class='import-layout btn green ']")
    end
    def btnModalConfirm
        sleep 5
        return @driver.find_element(:css, "button.confirm")        
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
    def dropdownOneImportLayout
        return @driver.find_element(:xpath, "//div[2]/div[3]/div/input")
    end
    def dropdownOneImportLayoutFirstItem
        return @driver.find_element(:xpath, "//div[3]/div/ul/li[2]/span")
    end
    def dropdownTwoPageImportLayout
        return @driver.find_element(:xpath, "//div[2]/div[4]/div/input")
    end
    def dropdownTwoPageImportLayoutFirstItem
        return @driver.find_element(:xpath, "//div[4]/div/ul/li[2]/span")
    end
    def dropdownThreePageImportLayout
        return @driver.find_element(:xpath, "//div[2]/div[5]/div/input")
    end
    def dropdownThreePageImportLayoutFirstItem
        return @driver.find_element(:xpath, "//div[5]/div/ul/li[2]/span")
    end

    #TOOGLES/SWITCHES
    def tooglePageStatus
        return @driver.find_element(:xpath, "//div[2]/div/p/div/label/span[2]")
    end

    #POPUPS
    def popUpSuccess
        return @driver.find_element(:xpath, "//div[@class='toast alert-box success active ember-view']")
    end

    #OTHERS
    def statusIndividualLastNavPage
        return @driver.find_element(:xpath, "//ul[@class='collection pages z-depth-1 nav ember-view']/li[last()]/div/div/div/div[2]/span[2]/span")
    end
    def importingPageStatusLastNavPage
        return @driver.find_element(:css, "span.pulsate")
    end
    
    #METHODS
    def refreshAndWait
        @driver.navigate.refresh
        @wait.until{@driver.find_element(:xpath, "//ul[@class='collection pages z-depth-1 nav ember-view']")}
    end
    def is_element_present(how, what)
        @driver.manage.timeouts.implicit_wait = 0
        result = @driver.find_elements(how, what).size() > 0
        if result
            result = @driver.find_element(how, what).displayed?
        end
        @driver.manage.timeouts.implicit_wait = 30
        @driver.find_element(:xpath, "//ul[@class='collection pages z-depth-1 nav ember-view']").displayed?
        return result
    end
end