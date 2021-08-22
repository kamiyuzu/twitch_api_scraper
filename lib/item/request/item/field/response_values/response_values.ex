defmodule TwitchApiScraper.Item.Request.Item.Field.ResponseValues do
  @moduledoc false

  alias TwitchApiScraper.Item.Request.Item
  alias TwitchApiScraper.Item.Request.Item.Field
  @behaviour Field

  @impl Field
  @spec parse({Item.all_fields(), tuple}) :: {Item.all_fields(), any}
  def parse({field, {"p", _, [value]}}) do
    description = value |> String.to_charlist |> hd
    case description do
      160 -> {field, []}
    end
  end
  def parse({field, {"p", _, list}}) do
    {field, %{description: Enum.map_join(list, &parse_inner(&1)), param: "", type: ""}}
  end

  def parse({field, {"table", _, [_headers, {"tbody", _, body_values}]}}) do
    {field, parse_body_values(body_values)}
  end

  def parse({field, {"table", _, [{"tbody", _, body_values}]}}) do
    {field, parse_body_values(body_values)}
  end

  defp parse_inner(value) when is_binary(value), do: value
  defp parse_inner({_, _, [value]}) when is_binary(value), do: value

  defp parse_body_values(body_values), do: Enum.map(body_values, &parse_body_value(&1))

  defp parse_body_value({"tr", _, body_value_rows}) do
    body_value_rows
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn
      {{_, _, [value]}, index}, acc when is_binary(value) ->
        put_value(index, value, acc)

      {{_, _, [{_, _, [value]}]}, _}, _ when value in ["Parameter", "Param", "Type", "Description"] ->
        []

      {{_, _, [{_, _, [value]}]}, index}, acc when is_binary(value) ->
        put_value(index, value, acc)

      {{_, _, description_raw}, index}, acc ->
        value = Enum.map_join(description_raw, &parse_description_raw(&1))
        put_value(index, value, acc)
    end)
  end

  defp parse_description_raw(value) when is_binary(value), do: value
  defp parse_description_raw({_, _, [value]}) when is_binary(value), do: value
  defp parse_description_raw({_, _, []}), do: []
  defp parse_description_raw({_, _, list}), do: Enum.map(list, &parse_inner_value(&1))

  defp parse_inner_value({_, _, inner_list}) do
    Enum.map_join(inner_list, fn
      value when is_binary(value) -> value
    end)
  end

  defp put_value(index, value, acc) do
    case index do
      0 -> Map.put(acc, :param, String.trim(value))
      1 -> Map.put(acc, :type, String.trim(value))
      2 -> Map.put(acc, :description, String.trim(value))
    end
  end
end
