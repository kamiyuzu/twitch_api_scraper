defmodule TwitchApiScraper.Item.Doc.Parser do
  @moduledoc false

  alias TwitchApiScraper.Item.Doc.Item
  alias TwitchApiScraper.Item.Doc.Item.{Description, Request, Response}

  @spec parse_doc_tree_item(Floki.html_tree()) :: %Item{}
  def parse_doc_tree_item(doc_item_raw) do
    with doc_item <- Floki.find(doc_item_raw, ".right-code"),
         descriptions <- Description.get_descriptions(doc_item),
         responses <- Response.get_example_response(doc_item),
         requests <- Request.get_example_request(doc_item) do
      %Item{
        responses: create_response_item(descriptions, responses),
        requests: create_request_item(descriptions, requests)
      }
    end
  end

  defp create_response_item(descriptions, responses) do
    descriptions
    |> Response.get_response_description()
    |> Response.create_response_item(responses)
  end

  defp create_request_item(descriptions, requests) do
    descriptions
    |> Request.get_request_description()
    |> Request.create_request_item(requests)
  end
end
