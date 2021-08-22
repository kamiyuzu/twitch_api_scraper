defmodule TwitchApiScraper.Tree.CompiledParser do
  @moduledoc false

  alias TwitchApiScraper.Tree.Parser

  @twitch_api_items Parser.scrape_twitch_api_items()

  @spec get_twitch_api_items :: Parser.api_items()
  def get_twitch_api_items, do: @twitch_api_items
end
