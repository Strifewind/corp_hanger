use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :corp_hanger, CorpHanger.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch", "--stdin",
                    cd: Path.expand("../", __DIR__)]]


# Watch static and templates for browser reloading.
config :corp_hanger, CorpHanger.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :corp_hanger, CorpHanger.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "corp_hanger_dev",
  hostname: "localhost",
  pool_size: 10


config :ueberauth, Ueberauth,
  providers: [
    eveonline: {Ueberauth.Strategy.EveOnline, []}
  ]

config :ueberauth, Ueberauth.Strategy.EveOnline.OAuth,
  client_id: System.get_env("EVEONLINE_CLIENT_ID"),
  client_secret: System.get_env("EVEONLINE_CLIENT_SECRET")

config :guardian, Guardian,
  issuer: "CorpHanger",
  ttl: { 30, :days },
  allowed_drift: 2000,
  secret_key: "230e33833b3c96ce6dc073206a0de91068ec3a8492cb816e66d88c9b85ca3efa846c6eb1192566ddea6630",
  serializer: CorpHanger.GuardianSerializer