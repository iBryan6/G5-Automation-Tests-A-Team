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
    def autoEmail
        @driver.find_element(:id, "user_email").send_keys("bryan.argandona-c@getg5.com")
    end
    def typeEmail
        puts "***\nType your G5 email:"
        email = gets 
        return @driver.find_element(:id, "user_email").send_keys(email)
    end

    #ADD YOUR G5 Password "have to find a better way to authenticate"
    def autoPassword
        @driver.find_element(:id, "user_password").send_keys("6Mishteamo6" + "\n")
    end
    def typePassword
        puts "Type your G5 password:"
        password = gets 
        @driver.find_element(:id, "user_password").send_keys(password)
    end
end