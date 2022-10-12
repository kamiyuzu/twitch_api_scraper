defmodule TwitchApiScraper.Item.Doc.ParserTest do
  use ExUnit.Case, async: true

  alias TwitchApiScraper.Tree.CompiledParser
  alias TwitchApiScraper.Item.Doc.{Parser, Item}
  alias TwitchApiScraper.Item.Doc.Item.{Request, Response}

  @parsed_tree CompiledParser.get_twitch_api_items()

  @parsed_tree
  |> Enum.with_index()
  |> Enum.each(fn {parsed_item_raw, index} ->
    parsed_item = Macro.escape(parsed_item_raw, unquote: true)

    describe "#{index} of #{length(@parsed_tree)}: get_doc_tree/0" do
      test "#{index} of #{length(@parsed_tree)}: checks doc item from the parsed tree retrieves a Doc struct" do
        assert %Item{} = Parser.parse_doc_tree_item(unquote(parsed_item))
      end

      test "#{index} of #{length(@parsed_tree)}: checks doc item from the parsed tree Doc struct description is correct" do
        assert Parser.parse_doc_tree_item(unquote(parsed_item)) != nil
      end

      test "#{index} of #{length(@parsed_tree)}: checks doc item from the parsed tree Doc struct response is correct" do
        assert %Item{responses: %Response{responses: _}} =
                 Parser.parse_doc_tree_item(unquote(parsed_item))
      end

      test "#{index} of #{length(@parsed_tree)}: checks doc item from the parsed tree Doc struct request is correct" do
        assert %Item{requests: %Request{requests: requests}} =
                 Parser.parse_doc_tree_item(unquote(parsed_item))

        assert length(requests) != 0
      end
    end
  end)
end
