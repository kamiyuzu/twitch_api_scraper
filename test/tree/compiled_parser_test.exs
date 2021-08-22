defmodule TwitchApiScraper.Tree.Parser.CompiledParserTest do
  use ExUnit.Case
  alias TwitchApiScraper.Tree.CompiledParser
  import Mock, only: [setup_with_mocks: 2, mock_modules: 1]

  @twitch_api_url Application.compile_env(:twitch_api_scraper, :twitch_api_url)
  @twitch_api_html Application.compile_env(:twitch_api_scraper, :twitch_api_html)
  @parsed_tree CompiledParser.get_twitch_api_items()

  setup_with_mocks([
    {HTTPoison, [],
     [
       get: fn @twitch_api_url ->
         {:ok, html} = File.read(@twitch_api_html)
         {:ok, %{body: html}}
       end
     ]}
  ]) do
    :ok
  end

  describe "scrape_twitch_api_items/0" do
    @parsed_tree
    |> Enum.with_index()
    |> Enum.each(fn {item, index} ->
      {_, _, escaped_item_value} = Macro.escape(item)

      test "checking item #{index} of #{length(@parsed_tree)} from the parsed tree" do
        assert ["section", [{"class", "doc-content"}], _] = unquote(escaped_item_value)
      end
    end)
  end
end
