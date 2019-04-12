# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :tractor_beam,
  ecto_repos: [TractorBeam.Repo]

# Configures the endpoint
config :tractor_beam, TractorBeamWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "zHBPeSK21ANlSBAm5Jud42aLe3N2rI+mR1VmiJiEFB1p0UFVgotqKusDxeNhbGRm",
  render_errors: [view: TractorBeamWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: TractorBeam.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :tractor_beam, TractorBeam.Repo,
  adapter: EctoMnesia.Adapter

config :ecto_mnesia,
  host: {:system, :atom, "MNESIA_HOST", Kernel.node()},
  storage_type: {:system, :atom, "MNESIA_STORAGE_TYPE", :disc_copies}

config :mnesia,
  dir: '/data/db'

config :tractor_beam, :phoenix_swagger,
  swagger_files: %{
    "priv/static/swagger.json" => [
      router: TractorBeamWeb.Router,     # phoenix routes will be converted to swagger paths
      endpoint: TractorBeamWeb.Endpoint  # (optional) endpoint config used to set host, port and https schemes.
    ]
  }
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
