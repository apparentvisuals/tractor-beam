defmodule TractorBeamWeb.SearchView do
  use TractorBeamWeb, :view

  def render("index.json", %{results: results}) do
    results
  end
end
