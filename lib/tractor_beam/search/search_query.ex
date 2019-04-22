defmodule TractorBeam.Search.SearchQuery do
  use Ecto.Schema
  import Ecto.Changeset
  alias TractorBeam.Search.SearchQuery

  @primary_key false
  embedded_schema do
    field :name, :string
    field :type, :string
    field :page, :string
  end

  @doc false
  def changeset(%SearchQuery{} = query, attrs) do
    query
    |> cast(attrs, [:type, :name, :page])
    |> validate_required([:type, :name])
    |> validate_inclusion(:type, ["movie", "tv"])
  end
end
