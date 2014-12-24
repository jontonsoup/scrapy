defmodule JB.Scraper do
  require Logger

  def start_link(opts) do
    JB.Populator.populate_url_list(Dotenv.get("start_url"))

    Logger.info "Finished Inserting Urls"
    scrape
    {:ok, self}
  end

  def scrape do
    urls = JB.Urls.unscraped_urls
    if urls do
      scrape_urls(urls)
    end
    scrape
  end

  def scrape_urls(urls) do
    if not Enum.empty? urls do
      Enum.map(urls, &(url_matcher(&1)))
    end
  end

  defp url_matcher(url_object) do
    %{_id: _, url: url, scraped: scraped?} = url_object
    scrape_url(url, scraped?)
    # {:ok, pid} = Task.Supervisor.start_link()
    # Task.Supervisor.async(pid, JB.Scraper, :scrape_url, [url, scraped?])
  end

  defp scrape_url(url, scraped? \\ false) do
    if not scraped? do
      {urls, body} = urls_for_page(url)
      urls |> Enum.map(fn(url) ->
        JB.Urls.insert_url(url)
      end)
      JB.Urls.visit!(url, body)
    end
  end

  defp urls_for_page(url) do
    body = HTTPService.get(url)
    if body != "" do
      urls = urls_for_html(body)
      {clean_urls(urls), body}
    else
      {[], ""}
    end
  end

  defp urls_for_html(body) do
    anchors = body |> FlokiService.find("a")
    anchors |> FlokiService.attribute("href")
  end

  defp clean_urls(urls) do
    Enum.uniq(urls) |> Enum.map(fn(url) -> clean_url(url) end)
  end

  defp clean_url(url) do
    if Regex.match?(~r/simplyhired.com\//, url) do
      url
    else
      Dotenv.get("base_url") <> url
    end
  end
end
