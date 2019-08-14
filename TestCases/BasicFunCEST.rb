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

#SETUP
driver = Selenium::WebDriver.for :chrome
driver.manage.window.maximize
wait = Selenium::WebDriver::Wait.new(:timeout => 20)

#LOGIN PAGE
auth = LoginPage.new(driver)
auth.goToPage(@url)
auth.typeEmail
auth.typePassword
auth.clickSubmit

#CLIENT LOCATION LIST
client = ClientPage.new(driver)
puts "Starting Basic Functionalities"
wait.until{driver.find_element(:xpath, "//ul[@class='collection locations']/li")}
client.btnEditFirstLocation.click
puts "Login Successfully"
sleep 5

#TEST CASES
#TC1
location = LocationPages.new(driver,wait)
puts "***\nTC1: Starting..."
location.btnCreateNewPage.click
location.inputPageName.send_keys(@newPageName)
location.btnSave.click
puts "TC1: Adding New Page"
wait.until{location.popUpSuccess}
puts "TC1: Success Popup Shown"
location.refreshAndWait()
wait.until {/New Page Test/.match(driver.page_source)} ? (puts "TC1: New Page Test Added Successfully") : (puts "TC1 ERROR: New Page Test Wasn't Found!")
puts "TC1: Complete!"
location.refreshAndWait()

#TC2
puts "***\nTC2: Starting..."
location.btnSettingsLastNavParentPage.click
location.inputPageName.clear
location.inputPageName.send_keys(@pageNameNewValue)
puts "TC2: Changing Page Name"
location.btnSave.click
wait.until{location.popUpSuccess}
puts "TC2: Success Popup Shown"
location.refreshAndWait()
location.btnSettingsLastNavParentPage.click
@nameValue = location.inputPageName.attribute('value')
(@nameValue == @pageNameNewValue) ? (puts "TC2: Name changed Successfully") : (puts "TC2 ERROR: Name wasn't changed!!")
puts "TC2: Complete!"
location.refreshAndWait()

#TC3
puts "***\nTC3: Starting..."
location.btnSettingsLastNavParentPage.click
location.inputPageTitle.clear
location.inputPageTitle.send_keys(@pageTitleNewValue)
puts "TC3: Changing Page Title"
location.btnSave.click
wait.until{location.popUpSuccess}
puts "TC3: Success Popup Shown"
location.refreshAndWait()
location.btnSettingsLastNavParentPage.click
@titleValue = location.inputPageTitle.attribute('value')
(@titleValue == @pageTitleNewValue) ? (puts "TC3: Title changed Successfully") : (puts "TC3 ERROR: Title wasn't changed!!")
puts "TC3: Complete!"
location.refreshAndWait()

#TC4
puts "***\nTC4: Starting..."
location.btnSettingsLastNavParentPage.click
location.inputPageDescription.clear
location.inputPageDescription.send_keys(@pageDescNewValue)
puts "TC4: Changing Page Description"
location.btnSave.click
wait.until{location.popUpSuccess}
puts "TC4: Success Popup Shown"
location.refreshAndWait()
location.btnSettingsLastNavParentPage.click
@descriptionValue = location.inputPageDescription.attribute('value')
(@descriptionValue == @pageDescNewValue) ? (puts "TC4: Description changed Successfully") : (puts "TC4 ERROR: Description wasn't changed!!")
puts "TC4: Complete!"
location.refreshAndWait()

#TC5
puts "***\nTC5: Starting..."
location.btnSettingsLastNavParentPage.click
location.dropdownParentChildPage.click
location.dropdownParentChildPageItem.click
location.btnSave.click
puts "TC5: Changing to a Child Page"
wait.until{location.popUpSuccess}
puts "TC5: Success Popup Shown"
location.refreshAndWait()
(location.pageTitleFirstChild.text.include?(@pageNameNewValue)) ? (puts "TC5: Changed to a Child Page Successfully") : (puts "TC5 ERROR: Page wasn't changed to a Child Page")
location.btnSettingsFirstNavChildPage(@pageNameNewValue).click
location.dropdownParentChildPage.click
location.dropdownParentChildPageNone.click
location.btnSave.click
puts "TC5: Changing to a Parent Page"
wait.until{location.popUpSuccess}
puts "TC5: Success Popup Shown"
location.refreshAndWait()
(location.pageTitleLastParent.text.include?(@pageNameNewValue)) ? (puts "TC5: Changed to a Parent Page Successfully") : (puts "TC5 ERROR: Page wasn't changed to a Parent Page")
puts "TC5: Complete!"
location.refreshAndWait()

#TC6
puts "***\nTC6: Starting..."
location.btnSettingsLastNavParentPage.click
location.tooglePageStatus.click
location.btnSave.click
puts "TC6: Changing Page Status to Disabled"
wait.until{location.popUpSuccess}
puts "TC6: Success Popup Shown"
location.refreshAndWait()
(location.statusIndividualLastNavPage.text.include?('Disabled Page')) ? (puts "TC6: Page was Disabled Successfully") : (puts "TC6 ERROR: Page wasn't Disabled")
location.btnSettingsLastNavParentPage.click
location.tooglePageStatus.click
location.btnSave.click
puts "TC6: Changing Page Status to Enabled"
wait.until{location.popUpSuccess}
puts "TC6: Success Popup Shown"
location.refreshAndWait()
(location.statusIndividualLastNavPage.text.include?('Disabled Page')) ? (puts "TC6 ERROR: Page wasn't Enabled Correctly") : (puts "TC6: Page was Enabled Successfully")
puts "TC6: Complete!"
location.refreshAndWait()

#TC7
puts "***\nTC7: Starting..."
location.btnSettingsLastNavParentPage.click
location.tabImportLayout.click
sleep 5
location.dropdownOneImportLayout.click
location.dropdownOneImportLayoutFirstItem.click
sleep 5
location.dropdownTwoPageImportLayout.click
location.dropdownTwoPageImportLayoutFirstItem.click
location.btnImportLayout.click
puts "TC7: Importing Page Layout from the same CMS"
location.btnModalConfirm.click
wait.until{location.popUpSuccess}
puts "TC7: Success Popup Shown"
location.refreshAndWait()
(location.importingPageStatusLastNavPage.text.include?('Importing Layout...')) ? (puts "TC7: Page is importing Successfully") : (puts "TC7 ERROR: Page is not importing!")
while (location.is_element_present(:css, "span.pulsate") == true) do
    driver.navigate.refresh
end
puts "TC7: Page Imported Successfully"
puts "TC7: Complete!"
location.refreshAndWait()

#TC8
puts "***\nTC8: Starting..."
location.btnSettingsLastNavParentPage.click
location.tabImportLayout.click
location.checkboxRemoteCMS.click
sleep 5
location.dropdownOneImportLayout.click
location.dropdownOneImportLayoutFirstItem.click
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
location.refreshAndWait()
(location.importingPageStatusLastNavPage.text.include?('Importing Layout...')) ? (puts "TC8: Page is importing Successfully") : (puts "TC8 ERROR: Page is not importing!")
while (location.is_element_present(:css, "span.pulsate") == true) do
    driver.navigate.refresh
end
puts "TC8: Page Imported Successfully"
puts "TC8: Complete!"
location.refreshAndWait()

driver.quit