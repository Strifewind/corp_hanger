defmodule CorpHanger.PageController do
  use CorpHanger.Web, :controller

  def index(conn, _params) do
    character = Guardian.Plug.current_resource(conn)
    render conn, "index.html", character: character
  end
end
