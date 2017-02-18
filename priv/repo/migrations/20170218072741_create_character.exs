defmodule CorpHanger.Repo.Migrations.CreateCharacter do
  use Ecto.Migration

  def change do
    create table(:characters) do
      add :name, :string, null: false
      add :access_token, :string
      add :refresh_token, :string
      add :eve_id, :bigint, null: false
      add :token_expiry, :datetime
      add :owner_hash, :string, null: false
      timestamps()
    end
    create index(:characters, [:eve_id], unique: true)
  end
end
