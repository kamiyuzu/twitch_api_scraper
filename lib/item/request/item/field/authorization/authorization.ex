defmodule TwitchApiScraper.Item.Request.Item.Field.Authorization do
  @moduledoc false

  alias TwitchApiScraper.Item.Request.Item
  alias TwitchApiScraper.Item.Request.Item.Field
  @behaviour Field

  @impl Field
  @spec parse({Item.all_fields(), tuple}) :: {Item.all_fields(), any}
  def parse({field, {_, _, list}}), do: {field, Enum.map_join(list, &parse_inner_value(&1))}
  defp parse_inner_value(value) when is_binary(value), do: value

  defp parse_inner_value({_, _, inner_list}) do
    Enum.map_join(inner_list, fn
      value when is_binary(value) -> value
      value -> parse_inner_value(value)
    end)
  end
end
