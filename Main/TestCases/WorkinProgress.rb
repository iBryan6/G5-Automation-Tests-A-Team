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
    def runTC8(remoteClient)
        puts "***\nTC8: Starting to import page layout from remote CMS..."
        sleep 10
        @location.btnSettings(@pageNameNewValue).click
        @location.tabImportLayout.click
        sleep 5
        @location.dropdownSelectClient.click
        sleep 5
        @location.dropdownContainsRemoteClient(remoteClient).click
        sleep 5
        @location.dropdownSelectLocation.click
        sleep 5
        @location.dropdownSelectLocationFirstItem.click
        sleep 5
        @location.dropdownSelectPage.click
        sleep 5
        @location.dropdownSelectPageFirstItem.click
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
        puts "***\nTC9: Starting to clone entire location from the same CMS..."
        @driver.navigate.to(url)
        sleep 5
        @client.tabCopyWebsites.click
        sleep 5
        @client.dropdownSourceLocation.click
        sleep 5
        @client.dropdownSourceLocationFirstItem.click
        @client.checkboxTargetWebsite(locationName).click
        @client.btnConfirmCopyWebsite.click
        @client.btnModalConfirm.click
        puts "TC9: Copying entire Local Location..."
        @wait.until{@client.popUpSuccess}
        puts "TC9: Success Popup Shown"
        @client.checkImporting(false)
        (@client.statusWebsite(locationName).text.include?('Updating')) ? (puts "TC9: Location is being copied") : (puts "TC9 ERROR: Location is not being copied!")
        @client.checkImporting(true)
        puts "TC9: Location Copied Successfully"
        puts "TC9: Complete!"
        @client.refreshAndNextTC()
    end
    def runTC10(url,remoteClient,locationName)
        puts "***\nTC10: Starting to clone entire location from remote CMS..."
        @driver.navigate.to(url)
        sleep 5
        @client.tabCopyWebsites.click
        sleep 5
        @client.dropdownSourceClient.click
        sleep 5
        @client.dropdownContainsRemoteClient(remoteClient).click
        sleep 5
        @client.dropdownSourceLocation.click
        sleep 5
        @client.dropdownSourceLocationFirstItem.click
        @client.checkboxTargetWebsite(locationName).click
        @client.btnConfirmCopyWebsite.click
        @client.btnModalConfirm.click
        puts "TC10: Copying entire Remote Location..."
        @wait.until{@client.popUpSuccess}
        puts "TC10: Success Popup Shown"
        @client.checkImporting(false)
        (@client.statusWebsite(locationName).text.include?('Updating')) ? (puts "TC10: Location is being copied") : (puts "TC10 ERROR: Location is not being copied!")
        @client.checkImporting(true)
        puts "TC10: Location Copied Successfully"
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
        sleep 5
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
        puts @remoteLocStripeNum
        @location.goToPage(url)
        @client.btnEditSelectedLoc(locationName).click
        sleep 5
        @driver.execute_script("window.scrollTo(0, 0)")
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
        puts @LocStripeNum
        puts "TC12: Comparing stripes..."
        if(@LocStripeNum == @remoteLocStripeNum)
            puts "TC12: Content Stripes copied correctly"
        else
            puts "TC12 ERROR: Something went wrong, stripes aren't the same!"
        end
        puts "TC12: Complete!"
        @client.refreshAndNextTC()
    end
end

basicTestSuite = TestCases.new(@url, @locationName)
basicTestSuite.runTC12(@url, @remoteClient, @locationName)

=begin
basicTestSuite.runTC7()
basicTestSuite.runTC8(@remoteClient)
basicTestSuite.runTC9(@url, @locationName)
basicTestSuite.runTC10(@url, @remoteClient, @locationName)
basicTestSuite.runTC11(@url, @remoteClient, @locationName)
=end