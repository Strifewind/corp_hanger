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

  def for_access_token(query, access_token) do
    from t in query,
      where: t.access_id == ^access_token
  end

  def corporation_id(character) do
    ESI.API.Character.corporation_history(character.eve_id)
    |> ESI.request!
    |> hd
    |> Map.get("corporation_id")
  end
    
  def portrait_url(character, size) do
    "//image.eveonline.com/Character/#{character.eve_id}_#{size}.jpg"
  end

  def corporation_name(character) do
    corporation_id(character)
    |> ESI.API.Corporation.corporation
    |> ESI.request!
    |> Map.get("corporation_name")
  end

  def corporation_img(character, size) do
    "//image.eveonline.com/Corporation/#{corporation_id(character)}_#{size}.png"
  end
  
  def assets(character) do
    ESI.API.Character.assets(character.eve_id, [token: character.access_token])
    |> ESI.stream!
    |> Enum.to_list
    |> Enum.filter(&in_hanger?/1)
#    |> IO.inspect
    |> Enum.group_by(&Map.get(&1, "location_id" ))
    |> Map.new
    |> IO.inspect
  end

  def asset_locations(character) do
    assets(character)
    |> Map.keys
    |> IO.inspect
    |> define_id
#    |> IO.inspect
  end

  def in_hanger?(%{"location_flag" => "Hangar", "location_type" => "station"}), do: true
  def in_hanger?(_), do: false
    
  def define_id(items, id_key) do
    ids = Enum.map(items, fn item -> Map.get(item, id_key) end)
    ESI.API.Universe.create_names(ids: ids)
    |> ESI.request!
  end

  def define_id(ids) when is_list(ids) do
    ESI.API.Universe.create_names(ids: ids)
    |> ESI.request!
  end
  def define_id(id) do
    ESI.API.Universe.create_names(ids: [id])
    |> ESI.request!
    |> hd
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
