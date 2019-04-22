defmodule TractorBeamWeb.NZBController do
  use TractorBeamWeb, :controller

  alias TractorBeam.Shows
  alias TractorBeam.Shows.Show
  alias TractorBeam.Indexers.NZBGeek

  action_fallback TractorBeamWeb.FallbackController

  def show(conn, %{"id" => id}) do
    case show = Shows.get_show!(id) do
      %Show{ imdb_id: id } -> 
        result = String.slice(id, 2..-1) |> NZBGeek.search_imdb_id
        render(conn, "show.json", items: result.items)
      _ -> {:error, "missing IMDB ID"}
    end
  end
end
