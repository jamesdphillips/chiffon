defmodule Cake.Mixfile do
  use Mix.Project

  def project do
    [
      app: :cake,
      version: "0.0.1",
      elixir: "~> 1.2",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps,
    ]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
      {:plug, "~> 1.0"},
      {:ecto, "~> 1.1"},
      {:postgrex, ">= 0.0.0"},
      {:shouldi, "~> 0.3", only: :test},
      {:mix_test_watch, "~> 0.2", only: :dev},
      {:dogma, "~> 0.0", only: :dev},
    ]
  end
end
