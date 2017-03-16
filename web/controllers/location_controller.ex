defmodule CorpHanger.LocationController do
  use CorpHanger.Web, :controller

  def show(conn, %{"id" => id}) do
    IO.inspect(id)
    location = %{id: id, name: CorpHanger.Character.define_id(String.to_integer(id))}
    render(conn, "show.html", location: location)
  end

end
