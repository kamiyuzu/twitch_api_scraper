defmodule TwitchApiScraper.Item.Doc.Item.RequestTest do
  use ExUnit.Case, async: true
  alias TwitchApiScraper.Item.Doc.Item.Request
  alias TwitchApiScraper.Tree.CompiledParser

  @parsed_tree CompiledParser.get_twitch_api_items()

  @parsed_tree
  |> Enum.with_index()
  |> Enum.each(fn {parsed_item_raw, index} ->
    doc_item_raw = Floki.find(parsed_item_raw, ".right-code")
    doc_item = Macro.escape(doc_item_raw, unquote: true)

    describe "#{index} of #{length(@parsed_tree)}: get_example_request/0" do
      test "#{index} of #{length(@parsed_tree)}: gets the example request from the parsed doc tree" do
        [example_request | _] = Request.get_example_request(unquote(doc_item))
        assert example_request != nil
      end
    end
  end)

  describe "get_request_description/1" do
    test "returns the expected descriptions" do
      descriptions_fixture = [
        "Gets the users who have been banned by Broadcaster 198704263.",
        "Shows that users glowillig and quotrok have been banned."
      ]

      expected_descriptions = ["Gets the users who have been banned by Broadcaster 198704263."]
      assert Request.get_request_description(descriptions_fixture) == expected_descriptions
    end
  end
end
