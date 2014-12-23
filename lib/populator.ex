defmodule JB.Populator do
  def populate_url_list do
    simply_hired_url = "http://www.simplyhired.com/job-search/title"
    JB.Scraper.urls_for_page(simply_hired_url)
      |> Enum.map(fn(url) -> JB.Urls.insert_url(url) end)
  end
end
