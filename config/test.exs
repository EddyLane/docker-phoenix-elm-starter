use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :playlist_pal, PlaylistPalWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :playlist_pal, PlaylistPal.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("PG_USERNAME"),
  password: System.get_env("PG_PASSWORD"),
  hostname: System.get_env("PG_HOST"),
  database: System.get_env("PG_DATABASE"),
  pool: Ecto.Adapters.SQL.Sandbox