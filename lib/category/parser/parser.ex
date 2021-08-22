defmodule TwitchApiScraper.Category.Parser do
  @moduledoc false

  alias TwitchApiScraper.Tree.Parser
  alias TwitchApiScraper.Category
  alias TwitchApiScraper.Category.{Resource, Action, Description, Id}

  @spec parse_categories(Parser.categories()) :: [Parser.categories()]
  def parse_categories(tree) do
    [{"tbody", [], categories}] = Floki.find(tree, "tbody")
    Enum.map(categories, &create_category_item(&1))
  end

  defp create_category_item(table_row) do
    %Category{
      id: Id.parse_id(table_row),
      action: Action.parse_action(table_row),
      resource: Resource.parse_resource(table_row),
      description: Description.parse_description(table_row)
    }
  end
end
