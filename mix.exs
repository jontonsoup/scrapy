defmodule Scrapy.Mixfile do
  use Mix.Project

  def project do
    [app: :jobboard,
     version: "0.0.1",
     elixir: "~> 1.0",
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:floki, :logger, :dotenv],
      mod: {Scrapy, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:apex, "~>0.3.2"},
      {:dotenv, github: "avdi/dotenv_elixir"},
      {:exvcr, git: "https://github.com/parroty/exvcr"},
      {:floki, git: "https://github.com/philss/floki"},
      {:httpotion, "~> 1.0.0"},
      {:ibrowse, github: "cmullaparthi/ibrowse", tag: "v4.1.0", override: true},
      {:mongo, git: "https://github.com/checkiz/elixir-mongo"}
    ]
  end
end
