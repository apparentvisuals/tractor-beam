defmodule TractorBeamWeb.DownloadControllerTest do
  use TractorBeamWeb.ConnCase

  alias TractorBeam.Downloads
  alias TractorBeam.Downloads.Download

  @create_attrs %{
    id: "7488a646-e31f-11e4-aace-600308960662",
    type: "some type"
  }
  @update_attrs %{
    id: "7488a646-e31f-11e4-aace-600308960668",
    type: "some updated type"
  }
  @invalid_attrs %{id: nil, type: nil}

  def fixture(:download) do
    {:ok, download} = Downloads.create_download(@create_attrs)
    download
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all downloads", %{conn: conn} do
      conn = get(conn, Routes.download_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create download" do
    test "renders download when data is valid", %{conn: conn} do
      conn = post(conn, Routes.download_path(conn, :create), download: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.download_path(conn, :show, id))

      assert %{
               "id" => id,
               "id" => "7488a646-e31f-11e4-aace-600308960662",
               "type" => "some type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.download_path(conn, :create), download: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update download" do
    setup [:create_download]

    test "renders download when data is valid", %{conn: conn, download: %Download{id: id} = download} do
      conn = put(conn, Routes.download_path(conn, :update, download), download: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.download_path(conn, :show, id))

      assert %{
               "id" => id,
               "id" => "7488a646-e31f-11e4-aace-600308960668",
               "type" => "some updated type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, download: download} do
      conn = put(conn, Routes.download_path(conn, :update, download), download: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete download" do
    setup [:create_download]

    test "deletes chosen download", %{conn: conn, download: download} do
      conn = delete(conn, Routes.download_path(conn, :delete, download))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.download_path(conn, :show, download))
      end
    end
  end

  defp create_download(_) do
    download = fixture(:download)
    {:ok, download: download}
  end
end
