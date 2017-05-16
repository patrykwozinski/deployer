require 'webrick'
require 'date'
require_relative 'manager'
require_relative 'deployer'

Dir["services/*.rb"].each do |service|
	require_relative service
end
