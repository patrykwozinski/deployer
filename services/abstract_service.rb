class AbstractService
	attr_accessor :env, :branch

	def initialize (env, branch)
		if !self.class::ENVIRONMENTS.include? env
			raise ArgumentError, 'Service environment doesn\'t exists!'
		end

    	@env = env
    	@branch = branch
    end

    def run_command (command)
    	Dir.chdir(self.class::DIRECTORY) do
			self.save_logs(%x{#{command}})
		end
    end

    def save_logs (logs)
    	current_date = Date.today.strftime("%Y-%m-%d")

		File.open("#{__dir__}/../logs/#{self.class.to_s}-#{@env}-#{current_date}.log", 'a+') do |file|
    		file.write("DEPLOY TIME: #{Time.now.getutc} \n" + logs + "\n\n")
    	end
    end
end
