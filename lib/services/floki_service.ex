defmodule FlokiService do
  def find(html, tag) do
    Floki.find(html, tag)
  end

  def attribute(html, attribute) do
    Floki.attribute(html, attribute)
  end
end
