defmodule TwitchApiScraper.Item.Request.Item do
  @moduledoc false

  @enforce_keys ~w(url)a
  @optional_fields [
    authentication: [],
    authorization: [],
    pagination: [],
    query_params: [],
    optional_query_params: [],
    body_params: [],
    optional_body_params: [],
    response_fields: [],
    response_codes: [],
    response_values: []
  ]
  @all_fields @enforce_keys ++ @optional_fields
  @derive Jason.Encoder
  defstruct @all_fields

  @type all_fields ::
          :authentication
          | :authorization
          | :body_params
          | :optional_body_params
          | :optional_query_params
          | :pagination
          | :query_params
          | :response_codes
          | :response_fields
          | :response_values
          | :url
  @type all_fields_list :: [all_fields]

  @spec all_fields :: all_fields_list
  def all_fields, do: @all_fields
end
