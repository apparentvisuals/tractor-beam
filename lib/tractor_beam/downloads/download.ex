defmodule TractorBeam.Downloads.Download do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, [autogenerate: true]}
  schema "downloads" do
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(download, attrs) do
    download
    |> cast(attrs, [:type])
    |> validate_required([:type])
  end
end
