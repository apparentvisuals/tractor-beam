defmodule TractorBeam.Repo.Migrations.CreateDownloads do
  use Ecto.Migration

  def change do
    create table(:downloads, primary_key: false) do
      add :id, :string, primary_key: true
      add :type, :string

      timestamps()
    end

  end
end
