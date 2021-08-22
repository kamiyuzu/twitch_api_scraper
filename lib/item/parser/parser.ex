defmodule TwitchApiScraper.Item.Parser do
  @moduledoc false

  alias TwitchApiScraper.Item
  alias TwitchApiScraper.Item.Doc
  alias TwitchApiScraper.Item.Request

  def item_parser(compiled_tree) do
    Enum.map(compiled_tree, &parse_item(&1))
  end

  defp parse_item(tree_item) do
    with id <- Item.Id.get_id(tree_item),
         doc <- Doc.Parser.parse_doc_tree_item(tree_item),
         request <- Request.Parser.parse_request_tree_item(tree_item) do
      %Item{id: id, doc: doc, request: request}
    end
  end
end
