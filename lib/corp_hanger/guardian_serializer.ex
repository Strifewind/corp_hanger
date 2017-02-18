defmodule CorpHanger.GuardianSerializer do
  @behaviour Guardian.Serializer

  alias CorpHanger.{Character, Repo}

  def for_token(%Character{} = char), do: {:ok, "Character:#{char.id}"}
  def for_token(_), do: {:error, "Unknown resource type"}

  def from_token("Character:" <> id), do: {:ok, Repo.get(Character, id)}
  def from_token(_), do: {:error, "Unknown resource type"}

end