defmodule TwitchApiScraper.Item do
  @moduledoc false

  @enforce_keys ~w(id doc)a
  @all_keys @enforce_keys ++ [request: [], category: []]
  @derive Jason.Encoder
  defstruct @all_keys
end
