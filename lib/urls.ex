defmodule JB.Urls do
  require Logger

  def insert_url(url) do
    MongoService.insert(%{url: url}, %{url: url, scraped: false})
  end

  def unscraped_urls do
    MongoService.find(%{scraped: false})
  end

  def visit!(url) do
    MongoService.insert(%{url: url}, %{url: url, scraped: true})
  end
end
