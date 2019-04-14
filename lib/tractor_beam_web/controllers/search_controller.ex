defmodule TractorBeamWeb.SearchController do
  use TractorBeamWeb, :controller

  alias TractorBeam.SearchQuery
  alias TractorBeam.Metadata.TMDB

  action_fallback TractorBeamWeb.FallbackController

  def index(conn, params) do
    with {:ok, %SearchQuery{} = query} <- validate(params) do
      with {:ok, results} <- TMDB.search(query) do
        render(conn, "index.json", results: results)
      end
    end
  end

  def validate(params \\ %{}) do
    %SearchQuery{} 
    |> SearchQuery.changeset(params)
    |> response
  end

  def response(%Ecto.Changeset{valid?: true} = changeset) do
    %{name: name, type: type} = changeset.changes
    {:ok, %SearchQuery{name: name, type: type}}
  end
  
  def response(%Ecto.Changeset{valid?: false} = changeset) do
    {:error, changeset}
  end
end
