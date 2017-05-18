defmodule CorpHanger.LocationController do
  use CorpHanger.Web, :controller

  def show(conn, %{"id" => id}) do
    IO.inspect(id)
    location = CorpHanger.Character.define_id(String.to_integer(id))
    |> IO.inspect
    assets = CorpHanger.Location.assets(location, conn)
    render(conn, "show.html", location: location, assets: assets, )
  end

end
