defmodule JB.Populator do
  def populate_url_list(url) do
    JB.Scraper.scrape_urls([%{_id: 0, url: url, scraped: false}])
  end
end
