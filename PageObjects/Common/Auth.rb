require "rubygems"
require "webdrivers"

class LoginPage
    def initialize(driver)
        @driver = driver
    end
    def goToPage(url)
        return @driver.navigate.to url
    end
    #ADD YOUR G5 EMAIL
    def typeEmail
        return @driver.find_element(:id, "user_email").send_keys("johnny.archer@getg5.com")
    end
    #ADD YOUR G5 Password "have to find a better way to authenticate"
    def typePassword
        return @driver.find_element(:id, "user_password").send_keys("g5rocksg5!")
    end
    def clickSubmit
        return @driver.find_element(:xpath, "//*[@id='new_user']/button").click
    end
end