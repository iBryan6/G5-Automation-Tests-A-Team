require "rubygems"
require "webdrivers"
require_relative "../../TestCases/BasicFunctionalities.rb"

#CHANGEABLE VARIABLES
##CLIENT AND LOCATION
@cms = 'https://cms.g5marketingcloud.com/clients/g5-c-5g1te7c7n-byron/websites'
@remoteClient = 'A1 U Store It'
@locationName = 'BRYAN TESTBED'

testSuite = TestCases.new(@cms, @locationName)
testSuite.runAll(@cms, @remoteClient, @locationName)