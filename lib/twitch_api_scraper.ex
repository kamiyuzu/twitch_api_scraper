defmodule TwitchApiScraper do
  @moduledoc false

  alias TwitchApiScraper.{Tree, Item}
  alias TwitchApiScraper.Category

  @spec generate_twitch_api_scraper :: any
  def generate_twitch_api_scraper do
    with twitch_api_categories <- Tree.Parser.scrape_twitch_api_categories(),
         twitch_api_items <- Tree.Parser.scrape_twitch_api_items() do
      build_items(twitch_api_items, twitch_api_categories)
    end
  end

  defp build_items(twitch_api_items, twitch_api_categories) do
    items = Item.Parser.item_parser(twitch_api_items)
    categories = Category.Parser.parse_categories(twitch_api_categories)

    parsed_items =
      items |> Enum.reduce([], &accumulate_categories(categories, &1, &2)) |> Enum.reverse()

    %{twitch_api_scraped_items: parsed_items}
  end

  defp accumulate_categories(categories, item, acc) do
    {[category], _} = Enum.split_with(categories, fn category -> category.id == item.id end)
    [Map.put(item, :category, category) | acc]
  end
end
