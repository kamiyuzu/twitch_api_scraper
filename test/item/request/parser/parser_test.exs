defmodule TwitchApiScraper.Item.Request.ParserTest do
  use ExUnit.Case, async: true

  alias TwitchApiScraper.Tree.CompiledParser
  alias TwitchApiScraper.Item.Request.{Parser, Item}

  @parsed_tree CompiledParser.get_twitch_api_items()

  @parsed_tree
  |> Enum.with_index()
  |> Enum.each(fn {parsed_item_raw, index} ->
    parsed_item = Macro.escape(parsed_item_raw, unquote: true)

    describe "#{index} of #{length(@parsed_tree)}: parse_request_tree_item/1" do
      test "#{index} of #{length(@parsed_tree)}: checks doc item from the parsed tree retrieves a Doc struct" do
        assert %Item{} = Parser.parse_request_tree_item(unquote(parsed_item))
      end
    end
  end)
end
