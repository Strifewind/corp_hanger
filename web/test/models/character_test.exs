defmodule CorpHanger.CharacterTest do
  use CorpHanger.ModelCase

  alias CorpHanger.Character

  @valid_attrs %{access_token: "some content", eve_id: 42, name: "some content", refresh_token: "some content", token_expiry: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Character.changeset(%Character{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Character.changeset(%Character{}, @invalid_attrs)
    refute changeset.valid?
  end
end
