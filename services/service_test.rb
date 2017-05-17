class ServiceTest < AbstractService
  DIRECTORY = '/'
  ENVIRONMENTS = %w[dev test]

  def deploy
    parameters = { hostname: 'localhost',
                   username: 'root',
                   password: nil,
                   commands: 'ls -l' }
    run_command(parameters)
    {
      message: 'The deployment was completed! Check logs for more information.',
      status_code: 200
    }
  end
end
