defmodule TwitchApiScraper.Fixtures.Html do
  @moduledoc false

  @spec get_html_from_twitch_api :: binary()
  def get_html_from_twitch_api do
    ensure_required_started_apps()
    twitch_api_url = Application.get_env(:twitch_api_scraper, :twitch_api_url)
    {:ok, resp} = HTTPoison.get(twitch_api_url)
    resp.body
  end

  defp ensure_required_started_apps do
    Application.ensure_all_started(:httpoison)
  end
end
