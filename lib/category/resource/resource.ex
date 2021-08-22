defmodule TwitchApiScraper.Category.Resource do
  @moduledoc false

  def parse_resource({_, _, [{_, _, [resource]}, _action, _description]}), do: resource
end
