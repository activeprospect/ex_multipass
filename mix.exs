defmodule ExMultipass.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_multipass,
      version: "0.3.0",
      elixir: "~> 1.12",
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
      name: "ex_multipass",
      source_url: "https://github.com/activeprospect/ex_multipass"
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
      {:credo, "~> 1.0", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.14", only: :test},
      {:stream_data, "~> 0.1", only: :test},
      {:ex_doc, "~> 0.21", only: :dev, runtime: false}
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
      links: %{"GitHub" => "https://github.com/activeprospect/ex_multipass"}
    ]
  end
end
