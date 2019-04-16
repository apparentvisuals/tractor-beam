defmodule TractorBeamWeb.ShowView do
  use TractorBeamWeb, :view
  alias TractorBeamWeb.ShowView

  def render("index.json", %{shows: shows}) do
    %{data: render_many(shows, ShowView, "show.json")}
  end

  def render("show.json", %{show: show}) do
    %{data: render_one(show, ShowView, "show.json")}
  end

  def render("show.json", %{show: show}) do
    %{id: show.id,
      type: show.type}
  end
end
