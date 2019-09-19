require "rubygems"
require "webdrivers"
require_relative "../../TestCases/BasicFunctionalities.rb"

#CHANGEABLE VARIABLES
##CLIENT AND LOCATION
@cms = 'https://cms.g5marketingcloud.com/clients/g5-c-5g1te7c7n-byron/websites'
@remoteClient = 'Oakland Management Multifamily - Client'
@locationName = 'BRYAN TESTBED'

basicTestSuite = BasicFunctionalities.new(@cms, @locationName)
basicTestSuite.runAll(@cms, @remoteClient, @locationName)