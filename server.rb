require_relative 'autoloader'

deployer_server = WEBrick::HTTPServer.new(:Port => ARGV.first)
deployer_server.mount '/', DeployManager

trap 'INT' do
  deployer_server.shutdown
end

deployer_server.start
