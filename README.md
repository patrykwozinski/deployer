# Ruby Gitlab deployer

### How to start server?
You can start your server using Ruby with command like
```ssh
    ruby server.rb <PORT>
```
---
### Make an example request to the server.
Request should be sended by `POST` method. You can use e.g. `CURL` by console command.
```ssh
    curl --data "service=Test&env=dev&branch=dev" http://localhost:<PORT> -H "X-Gitlab-Token:EXAMPLE_TOKEN"
```
Your query must have `service` key with name of service which you want to use, `env` filled by chosen environment and `branch` to pull correct application branch. It is required to have header named `X-Gitlab-Token` - must be the same as `config/gitlab-token.conf`.

---
### How to add a service.
Create your class into `services` directory named with prefix `Service` e.g. `ServiceSecondTest`. You need to implement:
- `DIRECTORY` - (CONST) must have your project envoy (or fabric) directory
- `ENVIRONMENTS` - (CONST) must be an array filled by available environments for your project
- `deploy` - (METHOD) with full commands to start in project directory and hash with symbols like `:message` and `:status_code`

Now you can make request to your deployer server with service name `SecondTest`.
