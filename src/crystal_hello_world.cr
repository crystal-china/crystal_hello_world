require "kemal"
require "raven"
require "raven/integrations/kemal"

# Perform basic raven configuration, none of it is required though
Raven.configure do |config|
  # Keep main fiber responsive by sending the events in the background
  config.async = true
  # Set the environment name using `Kemal.config.env`, which uses `KEMAL_ENV` variable under-the-hood
  config.current_environment = Kemal.config.env
end

# Replace the built-in `Kemal::LogHandler` with a
# dedicated `Raven::Kemal::LogHandler`, capturing all
# sent messages and requests as Sentry breadcrumbs

# If you'd like to preserve default logging provided by
# Kemal, pass `Kemal::LogHandler.new` to the constructor
if Kemal.config.logging
  Kemal.config.logger = Raven::Kemal::LogHandler.new(Kemal::LogHandler.new)
else
  Kemal.config.logger = Raven::Kemal::LogHandler.new
end

# Add raven's exception handler in order to capture
# all unhandled exceptions thrown inside your routes.
# Captured exceptions are re-raised afterwards
Kemal.config.add_handler Raven::Kemal::ExceptionHandler.new

get "/" do |env|
  env.redirect "/world"
end

get "/:name" do |env|
  name = env.params.url["name"]
  render "src/views/index.ecr"
end

# Register your explosive route
get "/will/:name/blend" do |env|
  if env.params.url["name"].downcase == "earth"
    # Earth doesn't blend, yet
    raise "Cling, Scratch, Boom!"
  else
    # All the rest will, obviously
    "Sure it will!"
  end
end

Kemal.run
