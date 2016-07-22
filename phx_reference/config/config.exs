# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :vanilla_phx,
  ecto_repos: [VanillaPhx.Repo]

# Configures the endpoint
config :vanilla_phx, VanillaPhx.Endpoint,
  url: [host: "localhost", path: "/newsite"],
  secret_key_base: "FWBifNX4zFosBNDq3sAZNLEo2LHO30VOt6ufjVhw5W8R1641L9WuoGy39wMj5PPS",
  render_errors: [view: VanillaPhx.ErrorView, accepts: ~w(html json)],
  pubsub: [name: VanillaPhx.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
