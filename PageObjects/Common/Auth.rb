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
<<<<<<< HEAD
        puts "***\nType your G5 email:"
=======
<<<<<<< HEAD
        return @driver.find_element(:id, "user_email").send_keys("johnny.archer@getg5.com")
    end
    #ADD YOUR G5 Password "have to find a better way to authenticate"
    def typePassword
        return @driver.find_element(:id, "user_password").send_keys("g5rocksg5!")
=======
        puts "Type your G5 email:"
>>>>>>> 60795ea2df9a19f88f56cacd77fc009a619346cf
        email = gets
        @driver.find_element(:id, "user_email").send_keys(email)
    end
    #ADD YOUR G5 Password "have to find a better way to authenticate"
    def autoPassword
<<<<<<< HEAD
        @driver.find_element(:id, "user_password").send_keys("6Mishteamo6" + "\n")
=======
        @driver.find_element(:id, "user_password").send_keys("" + "\n")
>>>>>>> a78e12c1adf706129b44737de5f115ec066aeaec
>>>>>>> 60795ea2df9a19f88f56cacd77fc009a619346cf
    end
    def typePassword
        puts "Type your G5 password:"
        password = gets 
        @driver.find_element(:id, "user_password").send_keys(password)
    end
end