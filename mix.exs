defmodule MultipassEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :multipass_ex,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage:     [tool: ExCoveralls],
      preferred_cli_env: [
        "coveralls":        :test,
        "coveralls.detail": :test,
        "coveralls.post":   :test,
        "coveralls.html":   :test
      ],
      dialyzer: [
        flags: [
          :unmatched_returns,
          :error_handling,
          :race_conditions,
          :no_opaque
        ]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:poison,      "~> 3.1"},
      {:credo,       "~> 0.9.0-rc1", only: [:dev, :test], runtime: false},
      {:dialyxir,    "~> 0.5",       only: [:dev],        runtime: false},
      {:excoveralls, "~> 0.8",       only: :test},
      {:stream_data, "~> 0.1",       only: :test},
    ]
  end
end
