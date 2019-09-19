require "rubygems"
require "webdrivers"
require_relative "../PageObjects/Common/Auth.rb"
require_relative "../PageObjects/Client/Clients.rb"
require_relative "../PageObjects/Location/LocationPages.rb"

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
    def runTC1
        puts "***\nTC1: Starting to create new page..."
        @location.btnCreateNewPage.click
        @location.inputPageName.send_keys(@newPageName)
        @location.btnSave.click
        puts "TC1: Adding New Page"
        @wait.until{@location.popUpSuccess}
        puts "TC1: Success Popup Shown"
        @location.refreshAndWait()
        @wait.until {/New Page Test/.match(@driver.page_source)} ? (puts "TC1: New Page Test Added Successfully") : (puts "TC1 ERROR: New Page Test Wasn't Found!")
        puts "TC1: Complete!"
        @location.refreshAndNextTC()
    end
    def runTC2
        puts "***\nTC2: Starting to change page name..."
        @location.btnSettings(@newPageName).click
        @location.inputPageName.clear
        @location.inputPageName.send_keys(@pageNameNewValue)
        puts "TC2: Changing Page Name"
        @location.btnSave.click
        @wait.until{@location.popUpSuccess}
        puts "TC2: Success Popup Shown"
        @location.refreshAndWait()
        @location.btnSettings(@pageNameNewValue).click
        @nameValue = @location.inputPageName.attribute('value')
        (@nameValue == @pageNameNewValue) ? (puts "TC2: Name changed Successfully") : (puts "TC2 ERROR: Name wasn't changed!!")
        puts "TC2: Complete!"
        @location.refreshAndNextTC()
    end
    def runTC3
        puts "***\nTC3: Starting to change page title..."
        @location.btnSettings(@pageNameNewValue).click
        @location.inputPageTitle.clear
        @location.inputPageTitle.send_keys(@pageTitleNewValue)
        puts "TC3: Changing Page Title"
        @location.btnSave.click
        @wait.until{@location.popUpSuccess}
        puts "TC3: Success Popup Shown"
        @location.refreshAndWait()
        @location.btnSettings(@pageNameNewValue).click
        @titleValue = @location.inputPageTitle.attribute('value')
        (@titleValue == @pageTitleNewValue) ? (puts "TC3: Title changed Successfully") : (puts "TC3 ERROR: Title wasn't changed!!")
        puts "TC3: Complete!"
        @location.refreshAndNextTC()
    end
    def runTC4
        puts "***\nTC4: Starting to change page description..."
        @location.btnSettings(@pageNameNewValue).click
        @location.inputPageDescription.clear
        @location.inputPageDescription.send_keys(@pageDescNewValue)
        puts "TC4: Changing Page Description"
        @location.btnSave.click
        @wait.until{@location.popUpSuccess}
        puts "TC4: Success Popup Shown"
        @location.refreshAndWait()
        @location.btnSettings(@pageNameNewValue).click
        @descriptionValue = @location.inputPageDescription.attribute('value')
        (@descriptionValue == @pageDescNewValue) ? (puts "TC4: Description changed Successfully") : (puts "TC4 ERROR: Description wasn't changed!!")
        puts "TC4: Complete!"
        @location.refreshAndNextTC()
    end
    def runTC5
        puts "***\nTC5: Starting to switch between child/parent page..."
        @location.btnSettings(@pageNameNewValue).click
        @location.dropdownParentChildPage.click
        @location.dropdownParentChildPageItem.click
        @location.btnSave.click
        puts "TC5: Changing to a Child Page"
        @wait.until{@location.popUpSuccess}
        puts "TC5: Success Popup Shown"
        @location.refreshAndWait()
        sleep 3
        (@location.pageTitleFirstChild.text.include?(@pageNameNewValue)) ? (puts "TC5: Changed to a Child Page Successfully") : (puts "TC5 ERROR: Page wasn't changed to a Child Page")
        sleep 5
        @location.btnSettings(@pageNameNewValue).click
        @location.dropdownParentChildPage.click
        @location.dropdownParentChildPageNone.click
        @location.btnSave.click
        puts "TC5: Changing to a Parent Page"
        @wait.until{@location.popUpSuccess}
        puts "TC5: Success Popup Shown"
        @location.refreshAndWait()
        (@location.pageTitleLastParent.text.include?(@pageNameNewValue)) ? (puts "TC5: Changed to a Parent Page Successfully") : (puts "TC5 ERROR: Page wasn't changed to a Parent Page")
        puts "TC5: Complete!"
        @location.refreshAndNextTC()
    end
    def runTC6
        puts "***\nTC6: Starting to switch between disabled/enabled page..."
        @location.btnSettings(@pageNameNewValue).click
        @location.tooglePageStatus.click
        @location.btnSave.click
        puts "TC6: Changing Page Status to Disabled"
        @wait.until{@location.popUpSuccess}
        puts "TC6: Success Popup Shown"
        @location.refreshAndWait()
        (@location.pageStatus(@pageNameNewValue).text.include?('Disabled Page')) ? (puts "TC6: Page was Disabled Successfully") : (puts "TC6 ERROR: Page wasn't Disabled")
        @location.btnSettings(@pageNameNewValue).click
        @location.tooglePageStatus.click
        @location.btnSave.click
        puts "TC6: Changing Page Status to Enabled"
        @wait.until{@location.popUpSuccess}
        puts "TC6: Success Popup Shown"
        @location.refreshAndWait()
        (@location.pageStatus(@pageNameNewValue).text.include?('Disabled Page')) ? (puts "TC6 ERROR: Page wasn't Enabled Correctly") : (puts "TC6: Page was Enabled Successfully")
        puts "TC6: Complete!"
        @location.refreshAndNextTC()
    end
    def runTC7
        puts "***\nTC7: Starting to import page layout from same CMS..."
        @location.btnSettings(@pageNameNewValue).click
        @location.tabImportLayout.click
        sleep 3
        @location.dropdownOneImportLayout.click
        @location.dropdownOneImportLayoutFirstItem.click
        sleep 5
        @location.dropdownTwoPageImportLayout.click
        @location.dropdownTwoPageImportLayoutFirstItem.click
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
    def runTC8(remoteClient)
        puts "***\nTC8: Starting to import page layout from remote CMS..."
        sleep 10
        @location.btnSettings(@pageNameNewValue).click
        @location.tabImportLayout.click
        @location.checkboxRemoteCMS.click
        sleep 5
        @location.dropdownOneImportLayout.click
        @location.dropdownContainsRemoteClient(remoteClient).click
        sleep 5
        @location.dropdownTwoPageImportLayout.click
        @location.dropdownTwoPageImportLayoutFirstItem.click
        sleep 5
        @location.dropdownThreePageImportLayout.click
        @location.dropdownThreePageImportLayoutFirstItem.click
        @location.btnImportLayout.click
        puts "TC8: Importing Page Layout from the a Remote CMS"
        @location.btnModalConfirm.click
        @wait.until{@location.popUpSuccess}
        puts "TC8: Success Popup Shown"
        @location.checkImporting(false, @pageNameNewValue)
        (@location.pageStatus(@pageNameNewValue).text.include?('Importing Layout...')) ? (puts "TC8: Page is importing") : (puts "TC8 ERROR: Page is not importing!")
        @location.checkImporting(true, @pageNameNewValue)
        puts "TC8: Page Imported Successfully"
        puts "TC8: Complete!"
        @location.refreshAndNextTC()
    end
    def runTC9(url, locationName)
        puts "***\nTC9: Starting to clone entire location to same CMS..."
        @driver.navigate.to(url)
        sleep 5
        @client.tabCopyWebsites.click
        @client.dropdownOneCopyWebsite.click
        @client.dropdownOneCopyWebsiteFirstItem.click
        @client.checkboxTargetWebsite(locationName).click
        @client.btnConfirmCopyWebsite.click
        @client.btnModalConfirm.click
        puts "TC9: Copying entire Website to Local Website"
        @wait.until{@client.popUpSuccess}
        puts "TC9: Success Popup Shown"
        @client.checkImporting(false)
        (@client.statusWebsite(locationName).text.include?('Updating')) ? (puts "TC9: Page is being copied") : (puts "TC9 ERROR: Page is not being copied!")
        @client.checkImporting(true)
        puts "TC9: Page Copied Successfully"
        puts "TC9: Complete!"
        @client.refreshAndNextTC()
    end
    def runTC10(url,remoteClient,locationName)
        puts "***\nTC10: Starting to clone entire location from remote CMS..."
        @driver.navigate.to(url)
        sleep 5
        @client.tabCopyWebsites.click
        @client.checkboxRemoteCMS.click
        sleep 5
        @client.dropdownOneCopyWebsite.click
        @client.dropdownContainsRemoteClient(remoteClient).click
        sleep 5
        @client.dropdownTwoCopyWebsite.click
        @client.dropdownTwoCopyWebsiteFirstItem.click
        sleep 5
        @client.checkboxTargetWebsite(locationName).click
        @client.btnConfirmCopyWebsite.click
        @client.btnModalConfirm.click
        puts "TC10: Copying entire Remote Website to Local Website"
        @wait.until{@client.popUpSuccess}
        puts "TC10: Success Popup Shown"
        @client.checkImporting(false)
        (@client.statusWebsite(locationName).text.include?('Updating')) ? (puts "TC10: Page is being copied") : (puts "TC10 ERROR: Page is not being copied!")
        @client.checkImporting(true)
        puts "TC10: Page Copied Successfully"
        puts "TC10: Complete!"
        @client.refreshAndNextTC()
    end
    def runTC11(url,remoteClient,locationName)
        puts "***\nTC11: Starting to check if styles copied successfully..."
        @remoteCmsURL = @client.getG5HubClientURL(remoteClient)
        @location.goToPage(@remoteCmsURL)
        @client.btnFirstLocEdit.click
        sleep 5
        @remoteLocPrimaryColor = @location.baseColorPrimary.attribute("style")
        @RemoteLocSecondaryColor = @location.baseColorSecondary.attribute("style")
        @RemoteLocTertiaryColor = @location.baseColorTertiary.attribute("style")
        puts "TC11: Retrieved remote CMS colors"
        @location.goToPage(url)
        @client.btnEditSelectedLoc(locationName).click
        sleep 5
        @LocalLocPrimaryColor = @location.baseColorPrimary.attribute("style")
        @LocalLocSecondaryColor = @location.baseColorSecondary.attribute("style")
        @LocalLocTertiaryColor = @location.baseColorTertiary.attribute("style")
        puts "TC11: Retrieved local CMS colors"
        puts "TC11: Comparing colors..."
        if(@remoteLocPrimaryColor == @LocalLocPrimaryColor && @RemoteLocSecondaryColor == @LocalLocSecondaryColor && @RemoteLocTertiaryColor == @LocalLocTertiaryColor)
            puts "TC11: Global Styles copied successfully"
        else
            puts "TC11 ERROR: Something went wrong, styles are not the same!"
        end
        puts "TC11: Complete!"
        @client.refreshAndNextTC()
    end
    def runTC12(url,remoteClient,locationName)
        puts "***\nTC12: Starting to check content stripes..."
        @remoteCmsURL = @client.getG5HubClientURL(remoteClient)
        @location.goToPage(@remoteCmsURL)
        @client.btnFirstLocEdit.click
        sleep 10
        puts "TC12: Retrieving remote location content stripes"
        if (@location.checkIfNavigationPagesExist() == true)
            @location.btnSettingsFirstNavPage.click
            sleep 5
            @remoteLocStripeNum = @location.checkPageStripeNum
        else
            @location.btnSettingsFirstOtherPage.click
            sleep 5
            @remoteLocStripeNum = @location.checkPageStripeNum
        end
        puts "TC12: Retrieved remote location content stripes"
        @location.goToPage(url)
        @client.btnEditSelectedLoc(locationName).click
        sleep 10
        puts "TC12: Retrieving location content stripes"
        if (@location.checkIfNavigationPagesExist() == true)
            @location.btnSettingsFirstNavPage.click
            sleep 5
            @LocStripeNum = @location.checkPageStripeNum
        else
            @location.btnSettingsFirstOtherPage.click
            sleep 5
            @LocStripeNum = @location.checkPageStripeNum
        end
        puts "TC12: Retrieved location content stripes"
        puts "TC12: Comparing stripes..."
        if(@LocStripeNum == @remoteLocStripeNum)
            puts "TC12: Content Stripes copied correctly"
        else
            puts "TC12 ERROR: Something went wrong, stripes aren't the same!"
        end
        puts "TC12: Complete!"
        @client.refreshAndNextTC()
    end
    def runAll(url,remoteClient,locationName)
        runTC1()
        runTC2()
        runTC3()
        runTC4()
        runTC5()
        runTC6()
        runTC7()
        runTC8(remoteClient)
        runTC9(url, locationName)
        runTC10(url,remoteClient,locationName)
        runTC11(url,remoteClient,locationName)
        runTC12(url,remoteClient,locationName)
    end
end