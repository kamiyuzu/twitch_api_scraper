defmodule TwitchApiScraper.Tree.Parser do
  @moduledoc false

  @type api_items :: [
          {binary(), [{binary(), binary()}, ...], [{binary(), binary(), binary()}, ...]},
          ...
        ]
  @type categories ::
          binary
          | {:comment, binary}
          | {:pi | binary, binary | [{any, any}], list}
          | {:doctype, binary, binary, binary}

  alias TwitchApiScraper.Fixtures.Html

  @html_items Html.get_html_from_twitch_api()

  @spec scrape_twitch_api_items :: api_items
  def scrape_twitch_api_items do
    tl(get_all_html_items())
  end

  @spec scrape_twitch_api_categories :: categories
  def scrape_twitch_api_categories do
    hd(get_all_html_items())
  end

  defp get_all_html_items do
    @html_items
    |> Floki.parse_document!()
    |> Floki.find(".doc-content")
  end
end
