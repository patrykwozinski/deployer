class DeployManager < WEBrick::HTTPServlet::AbstractServlet
    def do_POST (request, response)
        response.status = 406
        response.body = 'You have to choose the service, environment and branch. Request needs valid GitLab Token.'
        response.content_type = "text/plain"

        if self.is_valid_request?(request) && self.is_ok_token?(request['X-Gitlab-Token'])
            result = Deployer.new(
                'Service' + request.query['service'], request.query['env'], request.query['branch']
            ).start

            response.status = result[:status_code]
            response.body = result[:message].to_s + "\n"
        end
    end

    def is_valid_request? (request)
        request.query['service'] && request.query['env'] && request.query['branch'] && request.path == '/deploy'
    end

    def is_ok_token? (token)
        File.open('configs/gitlab-token.conf', 'a+').first == token
    end
end
