defmodule Slate.MixProject do
  use Mix.Project

  def project do
    [
      app: :slate,
      version: "0.3.1",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  def application do
    [
      mod: {Slate.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # Phoenix
      {:phoenix, "~> 1.5.6"},
      {:phoenix_ecto, "~> 4.2.1"},
      {:phoenix_live_view, "~> 0.14.7"},
      {:phoenix_html, "~> 2.14"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_dashboard, "0.3.6"},
      {:gettext, "~> 0.18.2"},
      {:jason, "~> 1.2"},

      # Plugs
      {:plug_cowboy, "~> 2.4"},
      {:plug_heartbeat, "~> 1.0"},

      # Database
      {:ecto_sql, "~> 3.5"},
      {:postgrex, "~> 0.15.7"},

      # Auth
      {:phx_gen_auth, "~> 0.6.0", only: [:dev], runtime: false},
      {:bcrypt_elixir, "~> 2.2"},

      # Mailing
      {:bamboo, "~> 2.0"},

      # Background Work
      {:oban, "~> 2.2"},

      # Telemetry
      {:telemetry_metrics, "~> 0.6.0"},
      {:telemetry_poller, "~> 0.5.1"},

      # Testing
      {:floki, "~> 0.30.0", only: [:test]},

      # Linting
      {:credo, "~> 1.4", only: [:dev, :test], override: true},
      {:credo_envvar, "~> 0.1", only: [:dev, :test], runtime: false},
      {:credo_naming, "~> 1.0", only: [:dev, :test], runtime: false},

      # Test factories
      {:ex_machina, "~> 2.4", only: :test},
      {:faker, "~> 0.16", only: :test},

      # Test coverage
      {:excoveralls, "~> 0.13", only: :test},

      # Convenience
      {:shorter_maps, "~> 2.2"}
    ]
  end

  defp aliases do
    [
      setup: ["deps.get", "ecto.setup", "cmd npm install --prefix assets"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end
end
