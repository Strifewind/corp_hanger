# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :corp_hanger,
  ecto_repos: [CorpHanger.Repo]

# Configures the endpoint
config :corp_hanger, CorpHanger.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "0zCGlf2tK6fijZgRcaHPpa92hBb47sOiOItP5sZZU/2XCq01hhOmjDpBuhvKCN2s",
  render_errors: [view: CorpHanger.ErrorView, accepts: ~w(html json)],
  pubsub: [name: CorpHanger.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
