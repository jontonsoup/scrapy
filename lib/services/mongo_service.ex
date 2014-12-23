defmodule MongoService do
  require Logger

  def start_link do
    {:ok, pid} = Agent.start_link(
        fn ->
          mongo = Mongo.connect!
          db = mongo |> Mongo.db("simply_hired_urls")
          collection = db |> Mongo.Db.collection("urls")
        end,
        name: :mongo_service
    )

    Logger.info "Started MongoService"
    {:ok, pid}
  end

  def insert(query, object) do
    collection = Agent.get(:mongo_service, fn connection -> connection end)
    Mongo.Collection.update(collection, query, object, true)
  end

  def find(statement) do
    collection = Agent.get(:mongo_service, fn connection -> connection end)
    results = collection |> Mongo.Collection.find(statement) |> Enum.to_list
  end
end

