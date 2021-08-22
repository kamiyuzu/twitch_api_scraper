defmodule TwitchApiScraper.Item.IdTest do
  use ExUnit.Case, async: true
  alias TwitchApiScraper.Item.Id
  alias TwitchApiScraper.Tree.CompiledParser

  @parsed_tree CompiledParser.get_twitch_api_items()

  @parsed_tree
  |> Enum.with_index()
  |> Enum.each(fn {parsed_item_raw, index} ->
    parsed_item = Macro.escape(parsed_item_raw, unquote: true)

    describe "#{index} of #{length(@parsed_tree)}: get_id/0" do
      test "#{index} of #{length(@parsed_tree)}: gets the example response from the parsed doc tree" do
        assert Id.get_id(unquote(parsed_item)) != nil
      end
    end
  end)
end
