# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :webchat,
  ecto_repos: [Webchat.Repo]

# Configures the endpoint
config :webchat, WebchatWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "rz1KwYb1kC1VSM73BIcE5Rwi+GAXseMm5oZ1pQvPOB/PT5ruB3GOLMBdFD+PhiKO",
  render_errors: [view: WebchatWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Webchat.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
