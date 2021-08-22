defmodule TwitchApiScraper.Item.Doc.Item.Request do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [:descriptions, :requests]

  alias __MODULE__
  alias TwitchApiScraper.Item.Doc.Item
  alias TwitchApiScraper.Item.Doc.Item.Response

  @typep descriptions :: [binary]
  @typep requests :: [binary]

  @spec create_request_item(descriptions, requests) :: %Request{}
  def create_request_item(descriptions, requests) do
    %Request{descriptions: descriptions, requests: requests}
  end

  @spec get_request_description(Floki.html_tree()) :: descriptions
  def get_request_description(doc_item) do
    Enum.reject(doc_item, &String.contains?(&1, Response.responses_starting_word()))
  end

  @spec get_example_request(Floki.html_tree()) :: requests
  def get_example_request(doc_item) do
    doc_item
    |> Floki.find("code")
    |> Item.parse_example_items()
    |> Item.parse_code_items()
    |> Enum.filter(&String.contains?(&1, ["curl"]))
  end
end
