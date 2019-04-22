defmodule TractorBeamWeb.SearchController do
  use TractorBeamWeb, :controller

  alias TractorBeam.Search.SearchQuery
  alias TractorBeam.Metadata.TMDB

  action_fallback TractorBeamWeb.FallbackController

  def index(conn, params) do
    with {:ok, %SearchQuery{type: type} = query} <- validate(params) do
      with {:ok, results} <- TMDB.search(query) do
        render(conn, "index.json", %{results: results, type: type})
      end
    end
  end

  def validate(params \\ %{}) do
    %SearchQuery{}
    |> SearchQuery.changeset(params)
    |> response
  end

  def response(%Ecto.Changeset{valid?: true} = changeset) do
    query = changeset.changes
    {:ok, %SearchQuery{name: query.name, type: query.type, page: query[:page]}}
  end
  
  def response(%Ecto.Changeset{valid?: false} = changeset) do
    {:error, changeset}
  end
end
