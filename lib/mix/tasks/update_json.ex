defmodule Mix.Tasks.UpdateJson do
  @moduledoc "Updates the json from api twitch reference url"
  @shortdoc "Updates the json from api twitch reference url"

  use Mix.Task
  alias TwitchApiScraper

  @fixture_json_path Application.compile_env(:twitch_api_scraper, :twitch_api_json)
  @fixture_pretty_json_path Application.compile_env(:twitch_api_scraper, :twitch_api_pretty_json)

  @impl Mix.Task
  @spec run(any) :: :ok
  def run(["pretty"]) do
    # This will start our application
    Mix.Task.run("app.start")

    scrapped_twitch_api_html = TwitchApiScraper.generate_twitch_api_scraper()
    json = Jason.encode!(scrapped_twitch_api_html, pretty: true)
    File.write!(@fixture_pretty_json_path, json)
  end

  def run(_) do
    # This will start our application
    Mix.Task.run("app.start")

    scrapped_twitch_api_html = TwitchApiScraper.generate_twitch_api_scraper()
    json = Jason.encode!(scrapped_twitch_api_html)
    File.write!(@fixture_json_path, json)
  end
end
