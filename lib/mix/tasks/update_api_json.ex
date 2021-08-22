defmodule Mix.Tasks.UpdateApiJson do
  @moduledoc "Updates the json scrapped from api twitch reference url"
  @shortdoc "Updates the json scrapped from api twitch reference url"

  use Mix.Task

  @impl Mix.Task
  @spec run(any) :: :ok
  def run(_args) do
    # This will start our application
    Mix.Task.run("app.start")

    updated_html = Mix.Task.run("update_html")
    Mix.shell().info(["update_html", ": ", Atom.to_string(updated_html)])
    updated_json = Mix.Task.run("update_json")
    Mix.shell().info(["update_json", ": ", Atom.to_string(updated_json)])
    updated_pretty_json = Mix.Task.rerun("update_json", ["pretty"])
    Mix.shell().info(["update_json ", ["pretty"], ": ", Atom.to_string(updated_pretty_json)])
  end
end
