defmodule TractorBeam.Shows.Show do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, [autogenerate: true]}
  schema "shows" do
    field :type, :string
    field :title, :string
    field :summary, :string
    field :poster_url, :string
    field :backdrop_url, :string
    field :external_id, :string
    timestamps()
  end

  @doc false
  def changeset(show, attrs) do
    show
    |> cast(attrs, [:type, :title, :summary, :poster_url, :backdrop_url, :external_id])
    |> validate_required([:type, :title, :external_id])
    |> validate_inclusion(:type, ["movie", "tv"])
  end
end
