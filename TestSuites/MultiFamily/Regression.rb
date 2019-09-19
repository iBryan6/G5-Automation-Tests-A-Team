require "rubygems"
require "webdrivers"
require_relative "../../TestCases/BasicFunctionalities.rb"

#CHANGEABLE VARIABLES
##CLIENT AND LOCATION
@cms = 'https://content-management-system-content-prime.g5devops.com/clients/g5-c-5g1te7c7n-byron/websites'
@remoteClient = 'Oakland Management Multifamily - Client'
@locationName = 'BRYAN TESTBED'

testSuite = TestCases.new(@cms, @locationName)
testSuite.runAll(@cms, @remoteClient, @locationName)