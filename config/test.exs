use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :tsundoku_buster, TsundokuBuster.Repo,
  username: "root",
  password: "",
  database: "tsundoku_buster_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :tsundoku_buster, TsundokuBusterWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :tsundoku_buster,
  twitter_client: ExTwitterMock,
  user_repo: TsundokuBuster.Repository.UserMock
