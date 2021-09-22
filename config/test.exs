use Mix.Config

# Print only warnings and errors during test
config :logger, level: :warn

config :twitch_api_scraper,
  twitch_api_html: "test/support/twitch_api.gzip"
