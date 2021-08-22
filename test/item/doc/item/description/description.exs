defmodule TwitchApiScraper.Item.Doc.Item.DescriptionTest do
  use ExUnit.Case, async: true
  alias TwitchApiScraper.Item.Doc.Item.Description
  alias TwitchApiScraper.Tree.CompiledParser

  @parsed_tree CompiledParser.get_twitch_api_items()

  @parsed_tree
  |> Enum.with_index()
  |> Enum.each(fn {parsed_item_raw, index} ->
    doc_item_raw = Floki.find(parsed_item_raw, ".right-code")
    doc_item = Macro.escape(doc_item_raw, unquote: true)

    describe "#{index} of #{length(@parsed_tree)}: get_description/0" do
      test "#{index} of #{length(@parsed_tree)}: gets description from the parsed doc tree" do
        assert Description.get_description(unquote(doc_item)) != nil
      end
    end
  end)
end
