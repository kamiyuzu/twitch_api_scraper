defmodule TwitchApiScraper.Category.Id do
  @moduledoc false

  @spec parse_id({any, any, [...]}) :: binary
  def parse_id(
        {_, _,
         [_resource, {_, _, [{_, [{_, <<_::binary-size(1), id::binary>>}], _}]}, _description]}
      ) do
    id
  end
end
