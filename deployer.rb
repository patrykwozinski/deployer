class Deployer
    attr_accessor :service, :env, :branch

    def initialize(service, env, branch)
        @service = service
        @env = env
        @branch = branch
    end

    def start

        if self.service_exists?
            Object.const_get(@service).new(env, branch).deploy
        else
            {message: 'Wrong service name.', status_code: 404}
        end

        rescue ArgumentError => error
            return {message: error.message, status_code: 404}
    end

    def service_exists?
        return Module.const_get(@service.to_s).is_a?(Class)

        rescue NameError
            return false
    end
end