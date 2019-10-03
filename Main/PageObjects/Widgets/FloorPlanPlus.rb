require "rubygems"
require "webdrivers"

class FloorPlanPlus
    def initialize(driver)
        @driver = driver
        @wait = wait
    end

    #CMS SETTINGS
    ##CONFIGS
    ###API Settings
    def locationURNInput
        return @driver.find_element(:xpath, "//input[@placeholder='location_urn']")
    end
    def inventoryHostInput
        return @driver.find_element(:xpath, "//input[@placeholder='https://inventory-integrations.g5devops.com']")
    end
    def vendorLeadsHostInput
        return @driver.find_element(:xpath, "//input[@placeholder='https://vendor-leads.g5marketingcloud.com']")
    end

    ###Layout
    def floorPlansCardsCarouselRadio
        return @driver.find_element(:xpath, "//input[@value='carousel']")
    end
    def floorPlansCardsGridRadio
        return @driver.find_element(:xpath, "//input[@value='grid']")
    end
    def condensedUnitsCheckbox
        return @driver.find_element(:xpath, "//label[.='Show condensed units view (mobile only)']/../input[@type='checkbox']")
    end

    ###Content
    def showAmenitiesFloorPlanCheckbox
        return @driver.find_element(:xpath, "//label[.='Show Amenities with Floor Plan']/../input[@type='checkbox']")
    end
    def amenitiesTitleInput
        return @driver.find_element(:xpath, "//input[@placeholder='Ready to make the move?']")
    end
    def leaseTermsCTAHeadingInput
        return @driver.find_element(:xpath, "//input[@placeholder='Apartment Amenities']")
    end
    def showVirtualTourLinkCheckbox
        return @driver.find_element(:xpath, "//label[.='Show Virtual Tour Link']/../input[@type='checkbox']")
    end
    def virtualTourInput
        return @driver.find_element(:xpath, "//input[@placeholder='Virtual Tour']")
    end
end