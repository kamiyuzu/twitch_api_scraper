defmodule TwitchApiScraper.Item.Id do
  @moduledoc false

  @spec get_id(Floki.html_tree()) :: binary
  def get_id(doc_item_raw) do
    [{_, [{_, id}], _} | _] = Floki.find(doc_item_raw, "h2")
    id
  end
end
