defmodule TwitchApiScraper.Category.ParserTest do
  use ExUnit.Case, async: true
  alias TwitchApiScraper.Tree
  alias TwitchApiScraper.Category

  setup_all do
    twitch_api_categories = Tree.Parser.scrape_twitch_api_categories()
    category_items = Category.Parser.parse_categories(twitch_api_categories)
    %{twitch_api_categories: twitch_api_categories}
  end

  describe "parse_categories/1" do
    test "checks the number of items", context do
      expected_category_items = Application.get_env(:twitch_api_scraper, :twitch_api_item_number)
      assert length(context.category_items) == expected_category_items
    end

    context.category_items
    |> Enum.with_index()
    |> Enum.each(fn category_item, index ->
      test "checks struct for item #{index} of #{length(context.category_items)}" do
        assert %Category{} = category_item
      end

      test "checks struct having field resource for item #{index} of #{length(context.category_items)}" do
        %Category{resource: resource} = category_item
        assert resource != nil
      end

      test "checks struct having field action for item #{index} of #{length(context.category_items)}" do
        %Category{action: action} = category_item
        assert action != nil
      end

      test "checks struct having field description for item #{index} of #{length(context.category_items)}" do
        %Category{description: description} = category_item
        assert description != nil
      end

      test "checks struct having field id for item #{index} of #{length(context.category_items)}" do
        %Category{id: id} = category_item
        assert id != nil
      end
    end)
  end
end
