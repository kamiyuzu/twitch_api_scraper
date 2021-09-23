defmodule TwitchApiScraperTest do
  use ExUnit.Case

  import Mock, only: [setup_with_mocks: 2, mock_modules: 1]

  @twitch_api_url Application.compile_env(:twitch_api_scraper, :twitch_api_url)
  @twitch_api_html Application.compile_env(:twitch_api_scraper, :twitch_api_html)

  setup_with_mocks([
    {HTTPoison, [],
     [
       get: fn @twitch_api_url ->
         {:ok, html} = File.open(@twitch_api_html, [:binary, :compressed], &IO.read(&1, :all))
         {:ok, %{body: html}}
       end
     ]}
  ]) do
    :ok
  end

  test "generate the twitch api json file" do
    %{twitch_api_scraped_items: screapped_items} = TwitchApiScraper.generate_twitch_api_scraper()
    assert length(screapped_items) > 0
  end
end
