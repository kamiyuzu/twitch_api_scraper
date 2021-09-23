defmodule TwitchApiScraper.Item.Request.Item.Field.Url do
  @moduledoc false

  alias TwitchApiScraper.Item.Request.Item
  alias TwitchApiScraper.Item.Request.Item.Field
  @behaviour Field

  @impl Field
  @spec parse({Item.all_fields(), tuple}) :: {Item.all_fields(), any}
  def parse({field, {_, _, [{_, _, [method_and_url_1]}, _, {_, _, [method_and_url_2]}]}}) do
    parsed_response =
      Enum.map([method_and_url_1, method_and_url_2], fn value ->
        case String.split(value, [" "]) do
          [method, url_part1, url_part2] ->
            %{method: method, url: url_part1 <> " " <> url_part2, description: ""}
        end
      end)

    {field, parsed_response}
  end

  def parse({field, {_, _, [{_, _, [method_and_url]} | _]}}) do
    parsed_response =
      case String.split(method_and_url, [" "]) do
        [method, url] -> %{method: method, url: url, description: ""}
        [url] -> %{method: "GET", url: url, description: ""}
      end

    {field, parsed_response}
  end

  def parse({field, {_, _, list}}),
    do:
      {field, %{description: Enum.map_join(list, &parse_description_raw/1), method: "", url: ""}}

  defp parse_description_raw(value) when is_binary(value), do: value
  defp parse_description_raw({_, _, [value]}) when is_binary(value), do: value
end
