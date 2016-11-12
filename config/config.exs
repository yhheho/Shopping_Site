# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :shopping_site,
  ecto_repos: [ShoppingSite.Repo]

# Configures the endpoint
config :shopping_site, ShoppingSite.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "n02NMxZSH0sS2xZYJe7iWSYOck72SZ5sL948yEggAc71JbiSJvnpdP+pTc5YJKfy",
  render_errors: [view: ShoppingSite.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ShoppingSite.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :shopping_site, ShoppingSite.Mailer,
  adapter: Bamboo.MailgunAdapter,
  api_key: System.get_env("MAILGUN_USERNAME"),
  domain: System.get_env("MAILGUN_PASSWORD")


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
