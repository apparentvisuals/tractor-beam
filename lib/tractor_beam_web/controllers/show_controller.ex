defmodule TractorBeamWeb.ShowController do
  use TractorBeamWeb, :controller

  alias TractorBeam.Shows
  alias TractorBeam.Shows.Show

  action_fallback TractorBeamWeb.FallbackController

  def index(conn, _params) do
    shows = Shows.list_shows()
    render(conn, "index.json", shows: shows)
  end

  def create(conn, %{"show" => show_params}) do
    with {:ok, %Show{} = show} <- Shows.create_show(show_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.show_path(conn, :show, show))
      |> render("show.json", show: show)
    end
  end

  def show(conn, %{"id" => id}) do
    show = Shows.get_show!(id)
    render(conn, "show.json", show: show)
  end

  def update(conn, %{"id" => id, "show" => show_params}) do
    show = Shows.get_show!(id)

    with {:ok, %Show{} = show} <- Shows.update_show(show, show_params) do
      render(conn, "show.json", show: show)
    end
  end

  def delete(conn, %{"id" => id}) do
    show = Shows.get_show!(id)

    with {:ok, %Show{}} <- Shows.delete_show(show) do
      send_resp(conn, :no_content, "")
    end
  end
end
