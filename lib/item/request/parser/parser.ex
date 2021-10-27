defmodule TwitchApiScraper.Item.Request.Parser do
  @moduledoc false

  alias TwitchApiScraper.Item.Request.Item
  alias TwitchApiScraper.Item.Request.Item.Field

  @spec parse_request_tree_item(Floki.html_tree()) :: any
  def parse_request_tree_item(request_item_raw) do
    with [{_, _, raw_items}] <- Floki.find(request_item_raw, ".left-docs") do
      parsed_fields = parse_request_items(raw_items)
      Enum.reduce(parsed_fields, %Item{url: parsed_fields[:url]}, &field_reducer(&1, &2))
    end
  end

  @spec field_reducer({Item.all_fields(), any}, %Item{}) :: %Item{}
  defp field_reducer({field, value}, acc), do: Map.put(acc, field, value)

  @spec parse_request_items([tuple], [{Item.all_fields(), [tuple]}]) :: [
          {Item.all_fields(), [tuple]}
        ]
  defp parse_request_items(items, acc \\ [])
  defp parse_request_items([], acc), do: acc
  defp parse_request_items([_], acc), do: acc

  defp parse_request_items([first | items], acc) do
    case parse_request_item_value(first) do
      nil ->
        parse_request_items(items, acc)

      requests_value_field ->
        {parsed_request, remaining_items} = parse_request_value(requests_value_field, items)
        parse_request_items(remaining_items, [parsed_request | acc])
    end
  end

  @spec parse_request_item_value({binary, any, [any]}) :: Item.all_fields() | nil
  defp parse_request_item_value({field, _, [value]}) when field in ~w(h3 h2) do
    field =
      Enum.filter(
        requests_values(),
        fn {_, request_values_list} ->
          String.contains?(value, request_values_list)
        end
      )

    case field do
      [{requests_value, _}] ->
        requests_value

      [{query_params_optional, _}, {query_params, _}] ->
        case String.contains?(value, "Optional") do
          false -> query_params
          true -> query_params_optional
        end

      [] ->
        nil
    end
  end

  defp parse_request_item_value(_), do: nil

  @spec parse_request_value(Item.all_fields(), [tuple]) :: {{Item.all_fields(), [tuple]}, [tuple]}
  defp parse_request_value(requests_field, raw_values) do
    parser_module = Field.get_parser_moudle(requests_field)

    {values, remaining_items} =
      Enum.split_while(raw_values, fn {entry, _, _} -> entry not in ~w(h3 h2) end)

    parsed_values =
      values
      |> Enum.map(fn value ->
        {_, parsed_request} = parser_module.parse({requests_field, value})
        parsed_request
      end)
      |> List.flatten()

    {{requests_field, parsed_values}, remaining_items}
  end

  @spec requests_values :: [{Item.all_fields(), [binary]}]
  defp requests_values do
    [
      authentication: ["Authentication"],
      authorization: ["Authorization"],
      body_params: ["Required Body Parameter"],
      optional_body_params: ["Optional Body Parameter"],
      optional_query_params: ["Optional Query Parameter"],
      pagination: ["Pagination Support"],
      query_params: ["Required Query Parameter", "Query Parameter"],
      response_codes: ["Response Codes"],
      response_fields: ["Response Field"],
      response_values: ["Return Value"],
      url: ["URL"]
    ]
  end
end
