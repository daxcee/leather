defmodule Leather.Mixfile do
  use Mix.Project

  def project do
    [
      app: :leather,
      version: "0.0.1",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  def application do
    [
      mod: {Leather.Application, []},
      extra_applications: [:sentry, :logger, :runtime_tools]
    ]
  end

  defp elixirc_paths(:test) do
    ["lib", "test/support"]
  end

  defp elixirc_paths(_) do
    ["lib"]
  end

  defp deps do
    [
      {:bcrypt_elixir, "~> 1.0"},
      {:comeonin, "~> 4.0.3"},
      {:cowboy, "~> 1.0"},
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
      {:gettext, "~> 0.14"},
      {:httpoison, "~> 0.13"},
      {:phoenix, "~> 1.3"},
      {:phoenix_ecto, "~> 3.3"},
      {:phoenix_html, "~> 2.10"},
      {:phoenix_live_reload, "~> 1.1", [only: :dev]},
      {:phoenix_pubsub, "~> 1.0"},
      {:poison, "~> 3.1"},
      {:postgrex, "~> 0.13"},
      {:sentry, "~> 6.0"}
    ]
  end

  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
