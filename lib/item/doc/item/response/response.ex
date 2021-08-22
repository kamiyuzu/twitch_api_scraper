defmodule TwitchApiScraper.Item.Doc.Item.Response do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [:descriptions, :responses]

  alias __MODULE__
  alias TwitchApiScraper.Item.Doc.Item

  @typep descriptions :: [binary]
  @typep responses :: [binary]

  @responses_starting_word ~w(Show Search If)

  @spec responses_starting_word :: [binary]
  def responses_starting_word, do: @responses_starting_word

  @spec create_response_item(descriptions, responses) :: %Response{}
  def create_response_item(descriptions, responses) do
    %Response{descriptions: descriptions, responses: responses}
  end

  @spec get_response_description(Floki.html_tree()) :: descriptions
  def get_response_description(descriptions) do
    Enum.filter(descriptions, &String.contains?(&1, responses_starting_word()))
  end

  @spec get_example_response(Floki.html_tree()) :: responses
  def get_example_response(doc_item) do
    doc_item
    |> Floki.find("code")
    |> Item.parse_example_items()
    |> Item.parse_code_items()
    |> Enum.reject(&String.contains?(&1, ["curl"]))
  end
end
