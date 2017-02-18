defmodule CorpHanger.SessionHelpers do

  def current_character(conn) do
    Guardian.Plug.current_resource(conn)
  end

  def signed_in?(conn) do
    !!current_character(conn)
  end

end