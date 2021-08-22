defmodule TwitchApiScraper.Item.Request.Item.Field do
  @moduledoc false

  alias __MODULE__
  alias TwitchApiScraper.Item.Request.Item

  @callback parse({Item.all_fields(), tuple}) :: {Item.all_fields(), any}

  def get_parser_moudle(:authentication), do: Field.Authentication
  def get_parser_moudle(:authorization), do: Field.Authorization
  def get_parser_moudle(:body_params), do: Field.BodyParams
  def get_parser_moudle(:optional_body_params), do: Field.OptionalBodyParams
  def get_parser_moudle(:optional_query_params), do: Field.OptionalQueryParams
  def get_parser_moudle(:pagination), do: Field.Pagination
  def get_parser_moudle(:query_params), do: Field.QueryParams
  def get_parser_moudle(:response_codes), do: Field.ResponseCodes
  def get_parser_moudle(:response_fields), do: Field.ResponseFields
  def get_parser_moudle(:response_values), do: Field.ResponseValues
  def get_parser_moudle(:url), do: Field.Url
end
