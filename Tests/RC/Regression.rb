require "rubygems"
require "webdrivers"
require_relative "../../Main/TestCases/BasicFunctionalities.rb"

#CHANGEABLE VARIABLES
##CLIENT AND LOCATION
@cms = 'https://content-management-system-content-prime.g5devops.com/clients/g5-c-5g1te7c7n-byron/websites'
@remoteClient = 'Apartment Management Professionals'
@locationName = 'BRYAN TESTBED'

basicTestSuite = BasicFunctionalities.new(@cms, @locationName)
basicTestSuite.runAll(@cms, @remoteClient, @locationName)