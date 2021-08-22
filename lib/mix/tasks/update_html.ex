defmodule Mix.Tasks.UpdateHtml do
  @moduledoc "Updates the fixture from api twitch reference url"
  @shortdoc "Updates the fixture from api twitch reference url"

  use Mix.Task
  alias TwitchApiScraper.Fixtures.Html

  @fixture_support_path Application.compile_env(:twitch_api_scraper, :twitch_api_html)

  @impl Mix.Task
  @spec run(any) :: :ok
  def run(_args) do
    # This will start our application
    Mix.Task.run("app.start")

    new_html = Html.get_html_from_twitch_api()
    File.write!(@fixture_support_path, new_html)
  end
end
