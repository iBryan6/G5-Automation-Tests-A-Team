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

    #BASECOLORS
    def baseColorPrimary
        return @driver.find_element(:xpath, "//p/div/div/div[2]/div/div/div")        
    end
    def baseColorSecondary
        return @driver.find_element(:xpath, "//p/div/div/div[3]/div/div/div")            
    end
    def baseColorTertiary
        return @driver.find_element(:xpath, "//p/div/div/div[4]/div/div/div")            
    end

    #BUTTONS
    def btnCreateNewPage
        return @driver.find_element(:xpath, "//div[@class='anchor-actions']/span/i")
    end
    def btnSave
        return @driver.find_element(:xpath, "//button[.=' Save']")
    end
    def btnSettings(newPageName)
        sleep 5
        return @driver.find_element(:xpath, "//span[.='#{newPageName}']/following-sibling::span/a[.=' Settings ']")
    end
    def btnSettingsFirstNavPage
        return @driver.find_element(:xpath, "//h4[.='Navigation Pages']/../following-sibling::div/div/ul/li/div/div/div/div[@class='name']/span[@class='page-actions']/a[normalize-space(.)='Settings']")
    end
    def btnSettingsFirstOtherPage
        return @driver.find_element(:xpath, "//h4[.='Other Pages']/../following-sibling::div/div/ul/li/div/div/div/div[@class='name']/span[@class='page-actions']/a[normalize-space(.)='Settings']")
    end
    def btnImportLayout
        sleep 5
        return @driver.find_element(:xpath, "//a[@class='import-layout btn green ']")
    end
    def btnModalConfirm
        sleep 5
        return @driver.find_element(:css, "button.confirm")        
    end
    def btnEditFirstNavPage
        return @driver.find_element(:xpath, "//h4[.='Navigation Pages']/../following-sibling::div/div/ul/li/div/div/div/div[@class='name']/span[@class='page-actions']/a[normalize-space(.)='Edit']")
    end
    def btnEditFirstOtherPage
        return @driver.find_element(:xpath, "//h4[.='Other Pages']/../following-sibling::div/div/ul/li/div/div/div/div[@class='name']/span[@class='page-actions']/a[normalize-space(.)='Edit']")
    end
    
    #DROPDOWNS
    def dropdownParentChildPage
        return @driver.find_element(:xpath, "//*[@class='input-field md-select ember-view']/div/input")
    end
    def dropdownParentChildPageItem
        sleep 3
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
    def dropdownContainsRemoteClient(client)
        return @driver.find_element(:xpath, "//span[contains(text(),'#{client}')]")
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
    def pageStatus(pageName)
        return @driver.find_element(:xpath, "//span[.='#{pageName}']/following-sibling::span/span")
    end
    
    #METHODS
    def refreshAndWait
        @driver.navigate.refresh
        @wait.until{@driver.find_element(:xpath, "//ul[@class='collection pages z-depth-1 nav ember-view']")}
    end
    def refreshAndNextTC
        @driver.navigate.refresh
        @wait.until{@driver.find_element(:xpath, "//ul[@class='collection pages z-depth-1 nav ember-view']")}
        sleep 10
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
    def checkImporting(status, pageName)
        while (is_element_present(:xpath, "//span[.='#{pageName}']/following-sibling::span/span/span") == status) do
            sleep 5
            @driver.navigate.refresh
            sleep 5
        end
    end
    def goToPage(url)
        @driver.navigate.to(url)
        sleep 5
    end
    def checkIfNavigationPagesExist
        return @driver.find_element(:xpath, "//h4[.='Navigation Pages']/../following-sibling::div/div/ul/li").size()!=0
    end
    def checkPageStripeNum
        i = 1
        while (@driver.find_elements(:xpath, "//a[normalize-space(@class)='active']/../../../../following-sibling::div/div/div[#{i}]").count()!=0)
            i+=1
        end
        return (i-1)
    end
end