defmodule TractorBeam.Repo.Migrations.CreateShows do
  use Ecto.Migration

  def change do
    create table(:shows, primary_key: false) do
      add :id, :string, primary_key: true
      add :type, :string

      add :title, :string
      add :summary, :string

      add :poster_url, :string
      add :backdrop_url, :string

      # indexer source
      add :external_id, :string
      add :external_source, :string

      # metadata
      add :imdb_id, :string

      timestamps()
    end
  end
end
