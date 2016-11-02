defmodule InframanEc2.Mixfile do
  use Mix.Project

  def project do
    [app: :inframan_ec2,
     version: "0.0.1",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     escript: [main_module: InframanEc2],
     aliases: aliases,
     deps: deps]
  end

  def aliases do
    [
      c: "escript.build"
    ]
  end

  def application do
    [applications: [:logger, :table_rex, :poison]]
  end

  defp deps do
    [
      {:table_rex, "~> 0.8"},
      {:poison, "~> 2.0"},
    ]
  end
end
