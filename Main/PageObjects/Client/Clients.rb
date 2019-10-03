 # This class will show all the locators and methods of this Page
require "rubygems"
require "webdrivers"

class ClientPage
    def initialize(driver, wait)
        @driver = driver
        @wait = wait
    end

    #BUTTONS
    def btnConfirmCopyWebsite
        return @driver.find_element(:xpath, "//a[normalize-space(.)='Copy Website']")
    end
    def btnModalConfirm
        sleep 5
        return @driver.find_element(:css, "button.confirm")        
    end
    def btnEditSelectedLoc(location)
        return @driver.find_element(:xpath, "//span[text()='#{location}']/../../../following-sibling::div/div[3]/a/span")
    end
    def btnFirstLocEdit
        return @driver.find_element(:xpath, "//a/span[.='Edit']")
    end
    def btnViewLocations
        return @driver.find_element(:xpath, "//a[.='View Locations']")
    end
    
    #TABS
    def tabCopyWebsites
        return @driver.find_element(:xpath, "//span[normalize-space(.)='Copy Website']")
    end


    #POPUPS
    def popUpSuccess
        return @driver.find_element(:xpath, "//div[@class='toast alert-box success active ember-view']")
    end

    #CHECKBOXES
    def checkboxTargetWebsite(location)
        return @driver.find_element(:xpath, "//label[contains(.,'#{location}')]")
    end

    #TAG A LINK
    def linkCorpDomain
        return @driver.find_element(:xpath, "//td[@class='col col-corporate']/i[@aria-hidden='true']/../../td[@class='col col-domain']/a")
    end
    #OTHERS
    def statusWebsite(location)
        return @driver.find_element(:xpath, "//span[@class='name'][.='#{location}']/../../../following-sibling::div/div[2]/span")
    end

    #DROPDOWNS
    def dropdownSourceClient
        return @driver.find_element(:xpath, "//div[4]/div/div/div[2]/div[1]/div/input")
    end
    def dropdownSourceClientFirstItem
        return @driver.find_element(:xpath, "//div[4]/div/div/div[2]/div[1]/div/ul/li[2]/span")
    end
    def dropdownSourceLocation
        return @driver.find_element(:xpath, "//div[4]/div/div/div[2]/div[2]/div/input")
    end
    def dropdownSourceLocationFirstItem
        return @driver.find_element(:xpath, "//div[4]/div/div/div[2]/div[2]/div/ul/li[2]/span")
    end

    def dropdownContainsRemoteClient(client)
        return @driver.find_element(:xpath, "//span[contains(text(),'#{client}')]")
    end
    
    #METHODS
    def refreshAndWait
        sleep 10
        @driver.navigate.refresh
        @wait.until{@driver.find_element(:xpath, "//ul[@class='collection locations']")}
    end
    def refreshAndNextTC
        @driver.navigate.refresh
        sleep 15
    end
    def is_element_present(how, what)
        @driver.manage.timeouts.implicit_wait = 0
        result = @driver.find_elements(how, what).size() > 0
        if result
            result = @driver.find_element(how, what).displayed?
        end
        @driver.manage.timeouts.implicit_wait = 30
        @driver.find_element(:xpath, "//ul[@class='collection locations']").displayed?
        return result
    end
    def checkImporting(status)
        while (is_element_present(:css, "span.pulsate") == status) do
            @driver.navigate.refresh
            sleep 5
        end
    end
    def getG5HubClientURL(client)
        @driver.navigate.to "https://g5-hub.herokuapp.com/"
        @driver.find_element(:id, "q_name").send_keys(client)
        @driver.action.send_keys(:enter).perform
        @driver.find_element(:link_text, client).click
        return @driver.find_element(:link_text, "Content Management System (CMS)").attribute("href")
    end
end