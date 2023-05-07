require "kemal"

get "/" do |env|
  env.redirect "/world"
end

get "/:name" do |env|
  name = env.params.url["name"]
  render "src/views/index.ecr"
end

Kemal.run
