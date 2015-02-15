defmodule ScrapyTest.MongoService do
  use ExUnit.Case, async: false

  setup do
    mongo = Mongo.connect!
    db = Mongo.db(mongo, "test")
    mongo_urls = Mongo.Db.collection(db, "urls")
    Mongo.Collection.drop mongo_urls

    {:ok,  mongo_urls: mongo_urls}
  end

  test "#insert", %{mongo_urls: mongo_urls} do
    # can insert record

    url = "http://test.com"
    test_url = %{url: url}

    MongoService.insert(test_url, test_url)

    assert(mongo_urls |> Mongo.Collection.find |> Enum.count == 1)

    urls = mongo_urls |> Mongo.Collection.find |> Enum.to_list
    %{_id: _, url: second_url} = hd(urls)
    assert(url == second_url)
  end

  test "#find", %{mongo_urls: mongo_urls} do
    # can find record
    first_test_url = %{url: "http://test.com", scraped: true}
    second_test_url = %{url: "http://secondtest.com", scraped: false}
    first_test_url |> Mongo.Collection.insert_one!(mongo_urls)
    second_test_url |> Mongo.Collection.insert_one!(mongo_urls)

    unscraped_urls = MongoService.find(%{scraped: false})
    test_url = hd(unscraped_urls)

    assert(second_test_url.url == test_url.url)
  end
end
