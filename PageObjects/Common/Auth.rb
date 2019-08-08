require "rubygems"
require "webdrivers"

class LoginPage
    def initialize(driver)
        @driver = driver
    end
    def goToPage(url)
        return @driver.navigate.to url
    end
    def typeEmail
        return @driver.find_element(:id, "user_email").send_keys("bryan.argandona-c@getg5.com")
    end
    def typePassword
        return @driver.find_element(:id, "user_password").send_keys("6Mishteamo6")
    end
    def clickSubmit
        return @driver.find_element(:xpath, "//*[@id='new_user']/button").click
    end
end