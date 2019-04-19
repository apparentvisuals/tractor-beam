defmodule TractorBeamWeb.ShowView do
  use TractorBeamWeb, :view
  alias TractorBeamWeb.ShowView

  def render("index.json", %{shows: shows}) do
    %{data: render_many(shows, ShowView, "one_show.json")}
  end

  def render("show.json", %{show: show}) do
    %{data: render_one(show, ShowView, "one_show.json")}
  end

  def render("one_show.json", %{show: show}) do
    %{id: show.id,
      type: show.type,
      title: show.title,
      summary: show.summary,
      poster_url: show.poster_url,
      backdrop_url: show.backdrop_url,
      external_id: show.external_id,
      external_source: show.external_source}
  end
end
