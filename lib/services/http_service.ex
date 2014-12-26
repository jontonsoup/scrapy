defmodule HTTPService do
  require Logger

  def get(url) do
    Logger.info("Starting #{url}")
    {:ok, _} = HTTPotion.start
    response = HTTPotion.get(url, [], proxy)

    case response do
      %HTTPotion.Response{body: body, status_code: 200} ->
        Logger.info("Scraped #{url}")
        body
      %HTTPotion.Response{status_code: 404} ->
        Logger.info("404 Error #{url}")
        ""
      %HTTPotion.Response{status_code: 301} ->
        Logger.info("301 Error #{url}")
        ""
      %HTTPotion.HTTPError{message: message} ->
        Logger.info(message)
        ""
      response ->
        Logger.info("Unrecognized response: #{inspect response}")
        ""
    end
  end

  defp proxy do
    :random.seed(:os.timestamp)

    proxy_list = [["65.49.14.133", 3129], ["189.59.9.218", 8080], ["212.120.189.11", 8080]]


    ip = hd(Enum.shuffle(proxy_list))

    Logger.info("Using #{hd(ip)}")
    [ib_options: [{:proxy_host, hd(ip)}, {:proxy_port, hd(tl(ip))}]]
  end
end
