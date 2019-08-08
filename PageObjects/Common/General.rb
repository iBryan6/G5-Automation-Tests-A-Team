require "rubygems"
require "webdrivers"

class General
    def initialize(driver)
        @driver = driver
    end
    def takeScreenShot
        @time = (Time.new).to_s
        return @driver.save_screenshot(@time)
    end
end