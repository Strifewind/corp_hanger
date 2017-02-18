defmodule CorpHanger.PageController do
  use CorpHanger.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
