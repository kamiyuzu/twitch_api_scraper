defmodule TwitchApiScraper.Item.Request.Item.Field.Authentication do
  @moduledoc false

  alias TwitchApiScraper.Item.Request.Item
  alias TwitchApiScraper.Item.Request.Item.Field
  @behaviour Field

  @impl Field
  @spec parse({Item.all_fields(), tuple}) :: {Item.all_fields(), any}
  def parse({field, {"p", _, [value]}}) when is_binary(value), do: {field, value}
  def parse({field, {"ul", _, list}}), do: {field, Enum.map(list, &parse_inner_value(&1))}
  def parse({field, {"p", _, list}}), do: {field, Enum.map(list, &parse_inner_list(&1))}

  defp parse_inner_value({_, _, inner_list}) when is_list(inner_list) do
    Enum.map_join(inner_list, fn
      value when is_binary(value) -> value
      {_, _, [value]} when is_binary(value) -> value
      {_, _, inner_list} -> Enum.map_join(inner_list, &parse_inner_list(&1))
    end)
  end

  defp parse_inner_list(value) when is_binary(value), do: value
  defp parse_inner_list({_, _, [value]}) when is_binary(value), do: value
end
