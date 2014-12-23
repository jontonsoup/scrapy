defmodule JB.Populator do
  def populate_url_list do
    simply_hired_url = "http://www.simplyhired.com/job-search/title"
    JB.Scraper.scrape_url(simply_hired_url)
  end
end
