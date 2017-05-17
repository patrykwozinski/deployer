require 'rubygems'
require 'net/ssh'

class SshConnector
  def initialize(hostname, username, password, commands)
    @hostname = hostname
    @username = username
    @password = password
    @commands = commands
  end

  def connect
    @connection = Net::SSH.start(@hostname, @username, password: @password)
    self
  end

  def run
    @connection.exec!(@commands)
    @connection.close
  end
end
