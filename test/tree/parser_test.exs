defmodule TwitchApiScraper.TreeParserTest do
  use ExUnit.Case, async: true
  alias TwitchApiScraper.Tree.Parser

  describe "scrape_twitch_api_items/0" do
    test "checks first item from the parsed tree" do
      first_item =
        Parser.scrape_twitch_api_items()
        |> hd
        |> Tuple.to_list()

      assert ["section", [{"class", "doc-content"}], _] = first_item
    end
  end
end
