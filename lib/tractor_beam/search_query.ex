defmodule TractorBeam.SearchQuery do
  use Ecto.Schema
  import Ecto.Changeset
  alias TractorBeam.SearchQuery

  @primary_key false
  embedded_schema do
    field :name, :string
    field :type, :string
  end

  @doc false
  def changeset(%SearchQuery{} = query, attrs) do
    query
    |> cast(attrs, [:type, :name])
    |> validate_required([:type, :name])
  end
end
