require "rubygems"
require "webdrivers"
require_relative "../PageObjects/Common/Auth.rb"
require_relative "../PageObjects/Client/Clients.rb"
require_relative "../PageObjects/Location/LocationPages.rb"

#CHANGEABLE VARIABLES
@url = 'https://g5-cms-5hq9qn3wg-javier-and-da.herokuapp.com/'
@newPageName = 'New Page Test'
@pageNameNewValue = 'New Page Name'
@pageTitleNewValue = 'New Page Title'
@pageDescNewValue = 'New Page Description'
@remoteClient = 'A1 U Store It'

#SETUP
driver = Selenium::WebDriver.for :chrome
wait = Selenium::WebDriver::Wait.new(:timeout => 20)
auth = LoginPage.new(driver)
location = LocationPages.new(driver,wait)
client = ClientPage.new(driver,wait)
driver.manage.window.maximize

#LOGIN PAGE
auth.goToPage(@url)
auth.typeEmail
auth.typePassword
auth.clickSubmit

#CLIENT LOCATION LIST
puts "Starting Basic Functionalities"
wait.until{driver.find_element(:xpath, "//ul[@class='collection locations']/li")}
sleep 5
client.btnEditSecondLocation.click
puts "Login Successfully"
sleep 5

#TEST CASES
class TestCases
    def initialize(driver,wait,location)
        @location = location
        @driver = driver
        @wait = wait
    end
    def runTC1(newPageName)
        puts "***\nTC1: Starting to create new page..."
        @location.btnCreateNewPage.click
        @location.inputPageName.send_keys(newPageName)
        @location.btnSave.click
        puts "TC1: Adding New Page"
        @wait.until{@location.popUpSuccess}
        puts "TC1: Success Popup Shown"
        @location.refreshAndWait()
        @wait.until {/New Page Test/.match(@driver.page_source)} ? (puts "TC1: New Page Test Added Successfully") : (puts "TC1 ERROR: New Page Test Wasn't Found!")
        puts "TC1: Complete!"
        @location.refreshAndNextTC()
    end
    def runTC2(pageNameNewValue)
        puts "***\nTC2: Starting to change page name..."
        @location.btnSettingsLastNavParentPage.click
        @location.inputPageName.clear
        @location.inputPageName.send_keys(pageNameNewValue)
        puts "TC2: Changing Page Name"
        @location.btnSave.click
        @wait.until{@location.popUpSuccess}
        puts "TC2: Success Popup Shown"
        @location.refreshAndWait()
        @location.btnSettingsLastNavParentPage.click
        @nameValue = @location.inputPageName.attribute('value')
        (@nameValue == pageNameNewValue) ? (puts "TC2: Name changed Successfully") : (puts "TC2 ERROR: Name wasn't changed!!")
        puts "TC2: Complete!"
        @location.refreshAndNextTC()
    end
    def runTC3(pageTitleNewValue)
        puts "***\nTC3: Starting to change page title..."
        @location.btnSettingsLastNavParentPage.click
        @location.inputPageTitle.clear
        @location.inputPageTitle.send_keys(pageTitleNewValue)
        puts "TC3: Changing Page Title"
        @location.btnSave.click
        @wait.until{@location.popUpSuccess}
        puts "TC3: Success Popup Shown"
        @location.refreshAndWait()
        @location.btnSettingsLastNavParentPage.click
        @titleValue = @location.inputPageTitle.attribute('value')
        (@titleValue == pageTitleNewValue) ? (puts "TC3: Title changed Successfully") : (puts "TC3 ERROR: Title wasn't changed!!")
        puts "TC3: Complete!"
        @location.refreshAndNextTC()
    end
    def runTC4(pageDescNewValue)
        puts "***\nTC4: Starting to change page description..."
        @location.btnSettingsLastNavParentPage.click
        @location.inputPageDescription.clear
        @location.inputPageDescription.send_keys(pageDescNewValue)
        puts "TC4: Changing Page Description"
        @location.btnSave.click
        @wait.until{@location.popUpSuccess}
        puts "TC4: Success Popup Shown"
        @location.refreshAndWait()
        @location.btnSettingsLastNavParentPage.click
        @descriptionValue = @location.inputPageDescription.attribute('value')
        (@descriptionValue == pageDescNewValue) ? (puts "TC4: Description changed Successfully") : (puts "TC4 ERROR: Description wasn't changed!!")
        puts "TC4: Complete!"
        @location.refreshAndNextTC()
    end
    def runTC5(pageNameNewValue)
        puts "***\nTC5: Starting to switch between child/parent page..."
        @location.btnSettingsLastNavParentPage.click
        @location.dropdownParentChildPage.click
        @location.dropdownParentChildPageItem.click
        @location.btnSave.click
        puts "TC5: Changing to a Child Page"
        @wait.until{@location.popUpSuccess}
        puts "TC5: Success Popup Shown"
        @location.refreshAndWait()
        (@location.pageTitleFirstChild.text.include?(pageNameNewValue)) ? (puts "TC5: Changed to a Child Page Successfully") : (puts "TC5 ERROR: Page wasn't changed to a Child Page")
        @location.btnSettingsFirstNavChildPage(pageNameNewValue).click
        @location.dropdownParentChildPage.click
        @location.dropdownParentChildPageNone.click
        @location.btnSave.click
        puts "TC5: Changing to a Parent Page"
        @wait.until{@location.popUpSuccess}
        puts "TC5: Success Popup Shown"
        @location.refreshAndWait()
        (@location.pageTitleLastParent.text.include?(pageNameNewValue)) ? (puts "TC5: Changed to a Parent Page Successfully") : (puts "TC5 ERROR: Page wasn't changed to a Parent Page")
        puts "TC5: Complete!"
        @location.refreshAndNextTC()
    end
    def runTC6()
        puts "***\nTC6: Starting to switch between disabled/enabled page..."
        @location.btnSettingsLastNavParentPage.click
        @location.tooglePageStatus.click
        @location.btnSave.click
        puts "TC6: Changing Page Status to Disabled"
        @wait.until{@location.popUpSuccess}
        puts "TC6: Success Popup Shown"
        @location.refreshAndWait()
        (@location.statusIndividualLastNavPage.text.include?('Disabled Page')) ? (puts "TC6: Page was Disabled Successfully") : (puts "TC6 ERROR: Page wasn't Disabled")
        @location.btnSettingsLastNavParentPage.click
        @location.tooglePageStatus.click
        @location.btnSave.click
        puts "TC6: Changing Page Status to Enabled"
        @wait.until{@location.popUpSuccess}
        puts "TC6: Success Popup Shown"
        @location.refreshAndWait()
        (@location.statusIndividualLastNavPage.text.include?('Disabled Page')) ? (puts "TC6 ERROR: Page wasn't Enabled Correctly") : (puts "TC6: Page was Enabled Successfully")
        puts "TC6: Complete!"
        @location.refreshAndNextTC()
    end
    def runTC7()
        puts "***\nTC7: Starting..."
        @location.btnSettingsLastNavParentPage.click
        @location.tabImportLayout.click
        sleep 5
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
        @location.checkImporting(true)
        (@location.importingPageStatus.text.include?('Importing Layout...')) ? (puts "TC7: Page is importing Successfully") : (puts "TC7 ERROR: Page is not importing!")
        @location.checkImporting(true)
        puts "TC7: Page Imported Successfully"
        puts "TC7: Complete!"
        @location.refreshAndNextTC()
        @location.refreshAndNextTC()
    end
end

testCase = TestCases.new(driver,wait,location)
testCase.runTC1(@newPageName)
testCase.runTC2(@pageNameNewValue)
testCase.runTC3(@pageTitleNewValue)
testCase.runTC4(@pageDescNewValue)
testCase.runTC5(@pageNameNewValue)
testCase.runTC6()
testCase.runTC7()
driver.quit

#TC8
puts "***\nTC8: Starting..."
location.btnSettingsLastNavParentPage.click
location.tabImportLayout.click
location.checkboxRemoteCMS.click
sleep 5
location.dropdownOneImportLayout.click
location.dropdownContainsRemoteClient(@remoteClient).click
sleep 5
location.dropdownTwoPageImportLayout.click
location.dropdownTwoPageImportLayoutFirstItem.click
sleep 5
location.dropdownThreePageImportLayout.click
location.dropdownThreePageImportLayoutFirstItem.click
location.btnImportLayout.click
puts "TC8: Importing Page Layout from the a Remote CMS"
location.btnModalConfirm.click
wait.until{location.popUpSuccess}
puts "TC8: Success Popup Shown"
location.checkImporting(true)
(location.importingPageStatus.text.include?('Importing Layout...')) ? (puts "TC8: Page is importing Successfully") : (puts "TC8 ERROR: Page is not importing!")
location.checkImporting(true)
puts "TC8: Page Imported Successfully"
puts "TC8: Complete!"
location.refreshAndNextTC()

#TC9
puts "***\nTC9: Starting..."
driver.navigate.to(@url)
sleep 5
client.tabCopyWebsites.click
client.dropdownOneCopyWebsite.click
client.dropdownOneCopyWebsiteFirstItem.click
client.checkboxTargetFirstWebsite.click
client.btnConfirmCopyWebsite.click
client.btnModalConfirm.click
puts "TC9: Copying entire Website to Local Website"
wait.until{client.popUpSuccess}
puts "TC9: Success Popup Shown"
client.checkImporting(false)
(client.statusWebsite.text.include?('Updating')) ? (puts "TC9: Page is being copied") : (puts "TC9 ERROR: Page is not being copied!")
client.checkImporting(true)
puts "TC9: Page Copied Successfully"
puts "TC9: Complete!"
client.refreshAndNextTC()

#TC10
puts "***\nTC10: Starting..."
client.tabCopyWebsites.click
client.checkboxRemoteCMS.click
sleep 5
client.dropdownOneCopyWebsite.click
client.dropdownContainsRemoteClient(@remoteClient).click
sleep 5
client.dropdownTwoCopyWebsite.click
client.dropdownTwoCopyWebsiteFirstItem.click
sleep 5
client.checkboxTargetFirstWebsite.click
client.btnConfirmCopyWebsite.click
client.btnModalConfirm.click
puts "TC10: Copying entire Remote Website to Local Website"
wait.until{client.popUpSuccess}
puts "TC10: Success Popup Shown"
client.checkImporting(false)
(client.statusWebsite.text.include?('Updating')) ? (puts "TC10: Page is being copied") : (puts "TC10 ERROR: Page is not being copied!")
client.checkImporting(true)
puts "TC10: Page Copied Successfully"
puts "TC10: Complete!"
client.refreshAndNextTC()

#TC11
puts "***\nTC11: Starting to check if styles copied successfully"
@remoteCmsURL = client.getG5HubClientURL(@remoteClient)
location.goToPage(@remoteCmsURL)
client.btnEditFirstLocation.click
sleep 5
@remoteLocPrimaryColor = location.baseColorPrimary.attribute("style")
@RemoteLocSecondaryColor = location.baseColorSecondary.attribute("style")
@RemoteLocTertiaryColor = location.baseColorTertiary.attribute("style")
puts "TC11: Retrieved remote CMS colors"
location.goToPage(@cms)
client.btnEditFirstLocation.click
sleep 5
@LocalLocPrimaryColor = location.baseColorPrimary.attribute("style")
@LocalLocSecondaryColor = location.baseColorSecondary.attribute("style")
@LocalLocTertiaryColor = location.baseColorTertiary.attribute("style")
puts "TC11: Retrieved local CMS colors"
puts "TC11: Comparing colors..."
if(@remoteLocPrimaryColor == @LocalLocPrimaryColor && @RemoteLocSecondaryColor == @LocalLocSecondaryColor && @RemoteLocTertiaryColor == @LocalLocTertiaryColor)
    puts "TC11: Global Styles copied successfully"
else
    puts "TC11 ERROR: Something went wrong, styles are not the same!"
end