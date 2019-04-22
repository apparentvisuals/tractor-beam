defmodule TractorBeamWeb.NZBView do
  use TractorBeamWeb, :view
  alias TractorBeamWeb.NZBView

  def render("show.json", %{items: items}) do
    %{total: length(items),
      data: render_many(items, NZBView, "nzb.json")}
  end

  def render("nzb.json", %{nzb: nzb}) do
    %{title: nzb.title,
      description: nzb.description,
      link: nzb.link}
  end
end
