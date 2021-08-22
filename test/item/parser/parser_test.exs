defmodule TwitchApiScraper.Tree.Parser.Item.ParserTest do
  use ExUnit.Case, async: true
  alias TwitchApiScraper.Item
  alias TwitchApiScraper.Item.Parser
  alias TwitchApiScraper.Tree.CompiledParser
  alias TwitchApiScraper.Item.Doc

  @parsed_tree CompiledParser.get_twitch_api_items()

  describe "item_parser/0" do
    test "check item parser behaviour works correctly" do
      parsed_items = Parser.item_parser(@parsed_tree)
      assert length(parsed_items) > 0
    end

    @parsed_tree
    |> Parser.item_parser()
    |> Enum.with_index()
    |> Enum.each(fn {item, index} ->
      escaped_item_value = Macro.escape(item, unquote: true)

      test "check item #{index} of #{length(@parsed_tree)} have correct struct" do
        assert %Item{id: id, doc: doc} = unquote(escaped_item_value)
        assert is_binary(id)
        assert %Doc.Item{} = doc
      end
    end)
  end
end
