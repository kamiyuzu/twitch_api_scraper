defmodule TwitchApiScraper.Item.Doc.Item.Description do
  @moduledoc false

  @typep description_value :: binary | list

  @spec get_descriptions(Floki.html_tree()) :: Floki.html_tree()
  def get_descriptions(doc_item) do
    doc_item
    |> Floki.find("p")
    |> parse_doc_item_descriptions()
  end

  @spec parse_doc_item_descriptions([Floki.html_tree()]) :: [binary]
  defp parse_doc_item_descriptions(doc_item) do
    doc_item
    |> Enum.map(&parse_doc_item_description/1)
    |> Enum.map(fn list -> Enum.map_join([list], & &1) end)
    |> Enum.filter(&String.match?(&1, ~r/\s/))
  end

  @spec parse_doc_item_description({any, any, any}) :: description_value
  defp parse_doc_item_description({_, _, description}),
    do: parse_doc_item_description_value(description)

  @spec parse_doc_item_description_value(description_value) :: description_value
  defp parse_doc_item_description_value([" "]), do: ""
  defp parse_doc_item_description_value([description]), do: description

  defp parse_doc_item_description_value(description),
    do: Enum.map(description, &parse_doc_item_value/1)

  @spec parse_doc_item_value(description_value) :: description_value
  defp parse_doc_item_value(" "), do: ""
  defp parse_doc_item_value({_, _, [value]}), do: value
  defp parse_doc_item_value(value), do: value
end
