# Get Mix output sent to the current
# process to avoid polluting tests.
Mix.shell(Mix.Shell.Process)

defmodule Mix.Tasks.UpdateApiJsonTest do
  use ExUnit.Case, async: true

  alias Mix.Tasks.UpdateApiJson

  describe "run/1" do
    test "generate the twitch api json file" do
      UpdateApiJson.run("")
      assert_received {:mix_shell, :info, ["update_html: ok"]}
      assert_received {:mix_shell, :info, ["update_json: ok"]}
      assert_received {:mix_shell, :info, ["update_json pretty: ok"]}
    end
  end
end
