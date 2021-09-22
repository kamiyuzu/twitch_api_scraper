defmodule TwitchApiScraper.Fixtures.HtmlTest do
  use ExUnit.Case
  alias TwitchApiScraper.Fixtures.Html
  import Mock, only: [setup_with_mocks: 2, mock_modules: 1, assert_called: 1]

  @twitch_api_url Application.compile_env(:twitch_api_scraper, :twitch_api_url)
  @twitch_api_html Application.compile_env(:twitch_api_scraper, :twitch_api_html)

  setup_with_mocks([
    {HTTPoison, [],
     [
       get: fn @twitch_api_url ->
          {:ok, html} = File.open(@twitch_api_html, [:binary, :compressed], &(IO.read(&1, :all)))
          {:ok, %{body: html}}
       end
     ]}
  ]) do
    :ok
  end

  describe "get_html_from_twitch_api/0" do
    test "checks first item from the parsed tree" do
      all_items = Html.get_html_from_twitch_api()

      assert <<"<!doctype html" <> _>> = all_items
      assert_called(HTTPoison.get(@twitch_api_url))
    end
  end
end
