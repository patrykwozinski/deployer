class ServiceTest < AbstractService
	DIRECTORY = "/"
	ENVIRONMENTS = ['dev', 'test']

	def deploy
		self.run_command("envoy run deploy-#{@env} --ver=#{@branch}")
		{:message => 'The deployment was completed! Check logs for more information.', :status_code => 200}
	end
end
