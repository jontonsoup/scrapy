defmodule JBTest.Scraper do
  use ExUnit.Case, async: false
  use ExVCR.Mock

  setup do
    mongo = Mongo.connect!
    db = Mongo.db(mongo, "test")
    mongo_urls = Mongo.Db.collection(db, "urls")
    Mongo.Collection.drop mongo_urls

    {:ok,  mongo_urls: mongo_urls}
  end

  test "#scrape_urls" do
    url = Dotenv.get("start_url")
    url_object = %{_id: 0, url: url, scraped: false}
    use_cassette "scrape_urls_test" do
      JB.Scraper.scrape_urls([url_object])

      assert(MongoService.find(%{}) |> Enum.count == 101)
    end
  end

end
