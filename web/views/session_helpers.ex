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
  
  def corporation_name(conn) do
    current_character(conn)
    |> CorpHanger.Character.corporation_name
  end

  def character_assets(conn) do
    current_character(conn)
  |> CorpHanger.Character.assets
  end
  
  @scopes ~w(
    characterAccountRead
    publicData
    characterFittingsRead
    characterAssetsRead
    esi-assets.read_assets.v1
    characterIndustryJobsRead
  )
  def scopes do
    @scopes
    |> Enum.join(" ")
  end

end