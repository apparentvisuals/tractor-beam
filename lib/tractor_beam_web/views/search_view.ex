defmodule TractorBeamWeb.SearchView do
  @backdrop_url "https://image/tmdb.org/t/p/w1280"
  @poster_url "https://image.tmdb.org/t/p/w92"

  use TractorBeamWeb, :view
  alias TractorBeamWeb.SearchView

  def render("index.json", %{results: results, type: type}) do
    %{page: results["page"],
      pages: results["total_pages"],
      total: results["total_results"],
      data: render_many(results["results"], SearchView, "result.json", %{as: :result, type: type})}
  end

  def render("show.json", %{result: result}) do
    %{data: render_one(result, SearchView, "result.json")}
  end

  def render("result.json", %{result: result, type: "movie"}) do
    %{id: Integer.to_string(result["id"]),
      title: result["title"],
      original_title: result["original_title"],
      summary: result["overview"],
      poster_url: "#{@poster_url}#{result["poster_path"]}",
      backdrop_url: "#{@backdrop_url}#{result["backdrop_path"]}"}
  end

  def render("result.json", %{result: result, type: "tv"}) do
    %{id: Integer.to_string(result["id"]),
      title: result["name"],
      original_title: result["original_name"],
      summary: result["overview"],
      poster_url: "#{@poster_url}#{result["poster_path"]}"}
  end
end
