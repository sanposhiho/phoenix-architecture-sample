# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :tsundoku_buster,
  ecto_repos: [TsundokuBuster.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :tsundoku_buster, TsundokuBusterWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "rgyhjErPhKioHk5tiLtNk3DyTcOvRozQGrHb/H5M5Md9ZdY9Dd3vsUSZ57KkLkwh",
  render_errors: [view: TsundokuBusterWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: TsundokuBuster.PubSub,
  live_view: [signing_salt: "sluMMrnj"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :tsundoku_buster,
  twitter_client: ExTwitter,
  user_repo: TsundokuBuster.Database.User

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
