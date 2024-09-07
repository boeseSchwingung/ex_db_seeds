defmodule ExDbSeeds.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_db_seeds,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      docs: [
        main: "Ex DB Seeds",
        extras: ["README.md"]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:ecto_sql, "~> 3.12"},
      {:ex_doc, ">= 0.0.0", runtime: false},
      {:inflex, "~> 2.1"},
      {:styler, "~> 1.0", only: [:dev, :test], runtime: false}
    ]
  end

  defp description do
    "Elixir library to manage database seeds."
  end

  defp package do
    [
      # This option is only needed when you don't want to use the OTP application name
      name: "ex_db_seeds",
      organization: "",
      # These are the default files included in the package
      files: ~w(lib .formatter.exs mix.exs README*),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/boeseSchwingung/ex_db_seeds"}
    ]
  end
end
