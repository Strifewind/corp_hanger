defmodule CorpHanger.SessionHelpers do

  def current_character(conn) do
    Guardian.Plug.current_resource(conn)
  end

  def signed_in?(conn) do
    !!current_character(conn)
  end

  def portrait_url(conn, size \\ 64) do
    current_character(conn)
    |> CorpHanger.Character.portrait_url(size)
  end
  

end