defmodule TractorBeamWeb.ShowControllerTest do
  use TractorBeamWeb.ConnCase

  alias TractorBeam.Shows
  alias TractorBeam.Shows.Show

  @create_attrs %{
    type: "some type"
  }
  @update_attrs %{
    type: "some updated type"
  }
  @invalid_attrs %{type: nil}

  def fixture(:show) do
    {:ok, show} = Shows.create_show(@create_attrs)
    show
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all shows", %{conn: conn} do
      conn = get(conn, Routes.show_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create show" do
    test "renders show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.show_path(conn, :create), show: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.show_path(conn, :show, id))

      assert %{
               "id" => id,
               "type" => "some type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.show_path(conn, :create), show: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update show" do
    setup [:create_show]

    test "renders show when data is valid", %{conn: conn, show: %Show{id: id} = show} do
      conn = put(conn, Routes.show_path(conn, :update, show), show: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.show_path(conn, :show, id))

      assert %{
               "id" => id,
               "type" => "some updated type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, show: show} do
      conn = put(conn, Routes.show_path(conn, :update, show), show: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete show" do
    setup [:create_show]

    test "deletes chosen show", %{conn: conn, show: show} do
      conn = delete(conn, Routes.show_path(conn, :delete, show))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.show_path(conn, :show, show))
      end
    end
  end

  defp create_show(_) do
    show = fixture(:show)
    {:ok, show: show}
  end
end
