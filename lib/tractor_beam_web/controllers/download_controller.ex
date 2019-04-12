defmodule TractorBeamWeb.DownloadController do
  use TractorBeamWeb, :controller

  alias TractorBeam.Downloads
  alias TractorBeam.Downloads.Download

  action_fallback TractorBeamWeb.FallbackController

  def index(conn, _params) do
    downloads = Downloads.list_downloads()
    render(conn, "index.json", downloads: downloads)
  end

  def create(conn, %{"download" => download_params}) do
    with {:ok, %Download{} = download} <- Downloads.create_download(download_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.download_path(conn, :show, download))
      |> render("show.json", download: download)
    end
  end

  def show(conn, %{"id" => id}) do
    download = Downloads.get_download!(id)
    render(conn, "show.json", download: download)
  end

  def update(conn, %{"id" => id, "download" => download_params}) do
    download = Downloads.get_download!(id)

    with {:ok, %Download{} = download} <- Downloads.update_download(download, download_params) do
      render(conn, "show.json", download: download)
    end
  end

  def delete(conn, %{"id" => id}) do
    download = Downloads.get_download!(id)

    with {:ok, %Download{}} <- Downloads.delete_download(download) do
      send_resp(conn, :no_content, "")
    end
  end
end
