defmodule CorpHanger.Character do
  use CorpHanger.Web, :model

  import Ecto.Query

  schema "characters" do
    field :name, :string
    field :access_token, :string
    field :refresh_token, :string
    field :eve_id, :integer
    field :token_expiry, Ecto.DateTime
    field :owner_hash, :string

    timestamps()
  end

  def for_eve_id(query, eve_id) do
    from t in query,
      where: t.eve_id == ^eve_id
  end

  def portrait_url(character, size) do
    "http://image.eveonline.com/Character/#{character.eve_id}_#{size}.jpg"
  end

  def corporation_name(character) do
    ESI.API.Character.corporation_history(character.eve_id)
    |> ESI.request!
    |> hd
    |> Map.get("corporation_id")
    |> ESI.API.Corporation.corporation
    |> ESI.request!
    |> Map.get("corporation_name")
  end


  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :access_token, :refresh_token, :owner_hash, :eve_id, :token_expiry])
    |> validate_required([:name, :access_token, :refresh_token, :owner_hash, :eve_id, :token_expiry])
  end
end
