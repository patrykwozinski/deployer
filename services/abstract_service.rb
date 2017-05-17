class AbstractService
  attr_accessor :env, :branch

  def initialize(env, branch)
    unless self.class::ENVIRONMENTS.include? env
      raise ArgumentError, 'Service environment doesn\'t exists!'
    end

    @env = env
    @branch = branch
  end

  def run_command(data)
    SshConnector.new(data[:hostname],
                     data[:username],
                     data[:password],
                     data[:commands]
    ).connect.run
    # Dir.chdir(self.class::DIRECTORY) { save_logs(%x(`#{command}`)) }
  end

  def save_logs(logs)
    current_date = Date.today.strftime('%Y-%m-%d')

    File.open("#{__dir__}/../logs/#{self.class.to_s}-#{@env}-#{current_date}.log", 'a+') { |file|
      file.write("DEPLOY TIME: #{Time.now.getutc} \n" + logs + "\n\n")
    }
  end
end
