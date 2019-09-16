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
        return @driver.find_element(:id, "user_email").send_keys("bryan.argandona-c@getg5.com")
    end
    #ADD YOUR G5 Password "have to find a better way to authenticate"
    def autoPassword
        @driver.find_element(:id, "user_password").send_keys("G5rocksg5" + "\n")
    end
    def typePassword
        puts "Type your G5 password:"
        password = gets 
        @driver.find_element(:id, "user_password").send_keys(password)
    end
end