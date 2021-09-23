defmodule Mix.Tasks.UpdateHtmlTest do
  use ExUnit.Case

  alias Mix.Tasks.UpdateHtml

  @fixture_path Application.compile_env(:twitch_api_scraper, :twitch_api_html)

  describe "fixture path" do
    test "checks if the fixture path is the expected one" do
      expected_path = "test/support/twitch_api.gzip"
      assert @fixture_path == expected_path
    end
  end

  describe "modifies expected file" do
    setup do
      File.rm!(@fixture_path)
      File.touch!(@fixture_path)
    end

    @tag argv: []
    test "checks if the file was updated", context do
      assert :ok = UpdateHtml.run(context[:argv])
      {:ok, html} = File.open(@fixture_path, [:binary, :compressed], &IO.read(&1, :all))
      assert <<"<!doctype html" <> _>> = html
    end
  end
end
