defmodule TractorBeam.Repo.Migrations.AddMetadataToDownloads do
  use Ecto.Migration

  def change do
    alter table(:downloads) do
      add :status, :string
      add :name, :string
      add :external_id, :string
    end
  end
end
