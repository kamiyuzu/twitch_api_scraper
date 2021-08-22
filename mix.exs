defmodule TwitchApiScraper.MixProject do
  use Mix.Project

  def project do
    [
      app: :twitch_api_scraper,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        update_html: :test
      ],
      dialyzer: [plt_add_apps: [:mix]]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application, do: [extra_applications: [:logger, :iex, :httpoison]]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:floki, "~> 0.31.0"},
      {:httpoison, "~> 1.8.0"},
      {:jason, "~> 1.2.2"},
      # Development
      {:mock, "~> 0.3.7", only: [:test], runtime: false},
      {:dialyxir, "~> 1.1.0", only: [:dev], runtime: false},
      {:credo, "~> 1.5.6", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.24.2", only: :dev},
      {:inch_ex, "~> 0.5.6", only: :dev},
      {:excoveralls, "~> 0.14.2", only: :test}
    ]
  end
end
