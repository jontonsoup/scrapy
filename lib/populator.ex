defmodule Scrapy.Populator do
  def populate_url_list(url) do
    Scrapy.Scraper.scrape_urls([%{_id: 0, url: url, scraped: false}])
  end
end
