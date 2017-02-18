defmodule CorpHanger.UseCases.Authentication do

  alias CorpHanger.{Character, Repo}

  def character(auth) do
    IO.inspect(auth)
    data = attributes_from_auth(auth)

    Character
    |> Character.for_eve_id(data.eve_id)
    |> Repo.one
    |> persist!(data)
  end

  defp attributes_from_auth(auth) do
    %{
      access_token: auth.credentials.token,
      eve_id: auth.credentials.other.character_id,
      name: auth.info.name,
      owner_hash: auth.credentials.other.character_owner_hash,
      refresh_token: auth.credentials.refresh_token,
      token_expiry: Ecto.DateTime.from_unix!(auth.credentials.expires_at, :seconds),
    }
  end

  defp persist!(nil, data) do
    struct(Character, data)
    |> Repo.insert!
  end
  defp persist!(existing, data) do
    existing
    |> Character.changeset(data)
    |> Repo.update!
  end

end