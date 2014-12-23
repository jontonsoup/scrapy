defmodule JB.Scraper do
  require Logger

  def start_link(opts) do
    JB.Populator.populate_url_list

    Logger.info "Finished Inserting Urls"
    scrape
    {:ok, self}
  end

  def scrape do
    urls = JB.Urls.unscraped_urls
    urls |> Enum.map(
      fn(url_object) ->
        %{_id: _, url: url, scraped: scraped?} = url_object
        if not scraped? do
          Apex.ap url
          # urls_for_page(url)

        end
      end)
  end

  def scrape_url(url) do
    urls_for_page(url)
      |> Enum.map(fn(url) -> JB.Urls.insert_url(url) end)
    JB.Urls.visit!(url)
  end

  defp urls_for_page(url) do
    {:ok, html} = HTTPoisonService.get(url)

    urls = html.body
    |> FlokiService.find("a")
    |> FlokiService.attribute("href")

    clean_urls(urls)
  end

  defp clean_urls(urls) do
    Enum.uniq(urls) |> Enum.map(fn(url) -> clean_url(url) end)
  end

  defp clean_url(url) do
    if Regex.match?(~r/http:\/\/www.simplyhired.com\//, url) do
      url
    else
      "http://simplyhired.com" <> url
    end
  end


end
