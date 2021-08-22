defmodule TwitchApiScraper.Category do
  @moduledoc false

  @enforce_keys ~w(id resource action description)a
  @derive Jason.Encoder
  defstruct @enforce_keys
end
