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
        return @driver.find_element(:xpath, "//div[5]/a")
    end
    def btnModalConfirm
        sleep 5
        return @driver.find_element(:css, "button.confirm")        
    end
    def btnEditSelectedLoc(selectedLoc)
        return @driver.find_element(:xpath, "//span[text()='#{selectedLoc}']/../../../following-sibling::div/div[3]/a/span")
    end
    
    #TABS
    def tabCopyWebsites
        return @driver.find_element(:xpath, "//div[2]/div[2]/span")
    end


    #POPUPS
    def popUpSuccess
        return @driver.find_element(:xpath, "//div[@class='toast alert-box success active ember-view']")
    end

    #CHECKBOXES
    def checkboxTargetFirstWebsite
        return @driver.find_element(:xpath, "//p/div/label")
    end
    def checkboxRemoteCMS
        return @driver.find_element(:xpath, "//div[4]/div/div/div/label")
    end

    #OTHERS
    def statusWebsite
        return @driver.find_element(:css, "span.pulsate")
    end

    #DROPDOWNS
    def dropdownOneCopyWebsite
        return @driver.find_element(:xpath, "//div[3]/div/div/input")
    end
    def dropdownOneCopyWebsiteFirstItem
        return @driver.find_element(:xpath, "//div[3]/div/div/ul/li[2]/span")
    end
    def dropdownTwoCopyWebsite
        return @driver.find_element(:xpath, "//div[3]/div[2]/div/input")
    end
    def dropdownTwoCopyWebsiteFirstItem
        return @driver.find_element(:xpath, "//div[3]/div[2]/div/ul/li[2]/span")
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