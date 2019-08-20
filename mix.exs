defmodule MultipassEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :multipass_ex,
      version: "0.2.0",
      elixir: "~> 1.6",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        "coveralls.travis": :test
      ],
      dialyzer: [
        flags: [
          :unmatched_returns,
          :error_handling,
          :race_conditions,
          :no_opaque
        ]
      ],

      # Docs
      name: "multipass_ex",
      source_url: "https://github.com/activeprospect/multipass_ex"
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:jason, "~> 1.0"},
      {:credo, "~> 0.9.0-rc1", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0.0-rc.3", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.8", only: :test},
      {:stream_data, "~> 0.1", only: :test},
      {:ex_doc, "~> 0.16", only: :dev, runtime: false}
    ]
  end

  defp description() do
    "Ruby compatible multipass encryption and decryption"
  end

  defp package() do
    [
      # These are the default files included in the package
      files: ["lib", "test", "config", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Frank Kumro"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/activeprospect/multipass_ex"}
    ]
  end
end
