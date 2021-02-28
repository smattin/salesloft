# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :salesloft,
  ecto_repos: [Salesloft.Repo]

# Configures the endpoint
config :salesloft, SalesloftWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "3rgXuEpm/KbeeTY/AfhUhq45BG8EKz0x1L6hqzjXu11dX4jZVR/UPDSVWQMGuohp",
  render_errors: [view: SalesloftWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Salesloft.PubSub,
  live_view: [signing_salt: "D66scZkW"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
