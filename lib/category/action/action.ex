defmodule TwitchApiScraper.Category.Action do
  @moduledoc false

  @spec parse_action({any, any, [...]}) :: any
  def parse_action({_, _, [_resource, {_, _, [{_, _, [action]}]}, _description]}), do: action
end
