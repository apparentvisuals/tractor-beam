defmodule TractorBeam.Downloads.Download do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, [autogenerate: true]}
  schema "downloads" do
    field :type, :string
    field :status, :string, default: "pending"
    field :name, :string
    field :external_id, :string
    timestamps()
  end

  @doc false
  def changeset(download, attrs) do
    download
    |> cast(attrs, [:type, :status, :name, :external_id])
    |> validate_required([:type, :status, :name, :external_id])
    |> validate_inclusion(:type, ["movie", "tv"])
    |> validate_inclusion(:status, [
      "pending",
      "not_monitored",
      "monitored",
      "downloading",
      "downloaded"
    ])
  end
end
