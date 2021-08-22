defmodule TwitchApiScraper.Item.Doc.Item do
  @moduledoc false

  @enforce_keys ~w(responses requests)a
  @derive Jason.Encoder
  defstruct @enforce_keys

  @typep code_item :: binary | {any, any, [binary]}
  @typep code_item_value :: binary | any

  @spec parse_example_items(Floki.html_tree(), list) :: [Floki.html_tree()]
  def parse_example_items(_, acc \\ [])
  def parse_example_items([], acc), do: acc

  def parse_example_items([example_item | tail], acc),
    do: parse_example_items(tail, [example_item | acc])

  @spec parse_code_items([code_item]) :: [binary]
  def parse_code_items(code_items) do
    code_items
    |> Enum.map(&parse_code/1)
    |> Enum.map(fn list -> Enum.map_join(list, & &1) end)
  end

  @spec parse_code(code_item) :: [binary]
  defp parse_code({"code", _, code_items}), do: Enum.map(code_items, &parse_code_item/1)

  @spec parse_code_item(code_item) :: binary
  defp parse_code_item(code_item) when is_binary(code_item), do: code_item
  defp parse_code_item({_, _, code_item}), do: parse_code_item_value(code_item)

  @spec parse_code_item_value(code_item_value) :: code_item_value
  defp parse_code_item_value(["\\"]), do: " \ \n "
  defp parse_code_item_value([]), do: ""
  defp parse_code_item_value([code_item]), do: code_item
end
