use Mix.Config

config :twitch_api_scraper,
  twitch_api_url: "https://dev.twitch.tv/docs/api/reference",
  twitch_api_html: "lib/fixtures/html/twitch_api.html",
  twitch_api_json: "lib/fixtures/json/twitch_api.json",
  twitch_api_pretty_json: "lib/fixtures/json/twitch_api_pretty.json"

import_config "#{Mix.env()}.exs"
