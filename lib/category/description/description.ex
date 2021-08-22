defmodule TwitchApiScraper.Category.Description do
  @moduledoc false

  @spec parse_description({any, any, [...]}) :: binary
  def parse_description({_, _, [_resource, _action, {_, _, [{_, _, description_raw}]}]}) do
    Enum.map_join(description_raw, &parse_description_item(&1))
  end

  def parse_description({_, _, [_resource, _action, {_, _, [{_, _, description_raw}, _]}]}) do
    Enum.map_join(description_raw, &parse_description_item(&1))
  end

  defp parse_description_item(description) when is_binary(description), do: description
  defp parse_description_item({_, _, [description]}) when is_binary(description), do: description

  defp parse_description_item({_, _, [{_, _, [description]}]}) when is_binary(description),
    do: description
end
