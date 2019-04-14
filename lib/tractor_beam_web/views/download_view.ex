defmodule TractorBeamWeb.DownloadView do
  use TractorBeamWeb, :view
  alias TractorBeamWeb.DownloadView

  def render("index.json", %{downloads: downloads}) do
    IO.inspect(downloads)
    %{data: render_many(downloads, DownloadView, "download.json")}
  end

  def render("show.json", %{download: download}) do
    %{data: render_one(download, DownloadView, "download.json")}
  end

  def render("download.json", %{download: download}) do
    %{id: download.id,
      type: download.type,
      status: download.status,
      name: download.name,
      external_id: download.external_id}
  end
end
