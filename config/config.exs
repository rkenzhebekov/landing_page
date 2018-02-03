# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :landing_page,
  ecto_repos: [LandingPage.Repo],
  google_recaptcha: [
    secret_key: System.get_env("GRECAPTCHA_SECRET_KEY") || "SECRET_KEY",
    site_key: System.get_env("GRECAPTCHA_SITE_KEY") || "SITE_KEY",
    client: LandingPage.Clients.GoogleRecaptchaHttp
  ]

# Configures the endpoint
config :landing_page, LandingPageWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "g8wFWiyjnmy+Qrbrq4CqsERsRl/a4cELTZ64S/Ga6F5ropWzVNbcMn5SmD1QQw+9",
  render_errors: [view: LandingPageWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: LandingPage.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
