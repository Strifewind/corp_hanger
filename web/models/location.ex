defmodule CorpHanger.Location do

  def assets(location, conn) do
    CorpHanger.SessionHelpers.character_assets(conn)
    |> Map.get(location["id"], [])
  end
  
end
