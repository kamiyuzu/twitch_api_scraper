defmodule Mix.Tasks.UpdateJsonTest do
  use ExUnit.Case, async: true

  alias Mix.Tasks.UpdateJson

  @fixture_path Application.compile_env(:twitch_api_scraper, :twitch_api_json)
  @fixture_pretty_json_path Application.compile_env(:twitch_api_scraper, :twitch_api_pretty_json)

  describe "modifies expected file" do
    setup do
      File.rm!(@fixture_path)
      File.touch!(@fixture_path)
    end

    @tag argv: []
    test "checks if the file was updated", context do
      assert :ok = UpdateJson.run(context[:argv])
      {:ok, html} = File.open(@fixture_path, [:binary, :compressed], &IO.read(&1, :all))
      assert <<"{\"twitch_api_scraped_items\":[" <> _>> = html
    end
  end

  describe "modifies expected pretty file" do
    setup do
      File.rm!(@fixture_pretty_json_path)
      File.touch!(@fixture_pretty_json_path)
    end

    @tag argv: ["pretty"]
    test "checks if the file was updated", context do
      assert :ok = UpdateJson.run(context[:argv])

      {:ok, json} =
        File.open(@fixture_pretty_json_path, [:binary, :compressed], &IO.read(&1, :all))

      assert <<"{\n  \"twitch_api_scraped_items\": [\n" <> _>> = json
    end
  end
end
