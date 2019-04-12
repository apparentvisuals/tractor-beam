defmodule TractorBeam.DownloadsTest do
  use TractorBeam.DataCase

  alias TractorBeam.Downloads

  describe "downloads" do
    alias TractorBeam.Downloads.Download

    @valid_attrs %{id: "7488a646-e31f-11e4-aace-600308960662", type: "some type"}
    @update_attrs %{id: "7488a646-e31f-11e4-aace-600308960668", type: "some updated type"}
    @invalid_attrs %{id: nil, type: nil}

    def download_fixture(attrs \\ %{}) do
      {:ok, download} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Downloads.create_download()

      download
    end

    test "list_downloads/0 returns all downloads" do
      download = download_fixture()
      assert Downloads.list_downloads() == [download]
    end

    test "get_download!/1 returns the download with given id" do
      download = download_fixture()
      assert Downloads.get_download!(download.id) == download
    end

    test "create_download/1 with valid data creates a download" do
      assert {:ok, %Download{} = download} = Downloads.create_download(@valid_attrs)
      assert download.id == "7488a646-e31f-11e4-aace-600308960662"
      assert download.type == "some type"
    end

    test "create_download/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Downloads.create_download(@invalid_attrs)
    end

    test "update_download/2 with valid data updates the download" do
      download = download_fixture()
      assert {:ok, %Download{} = download} = Downloads.update_download(download, @update_attrs)
      assert download.id == "7488a646-e31f-11e4-aace-600308960668"
      assert download.type == "some updated type"
    end

    test "update_download/2 with invalid data returns error changeset" do
      download = download_fixture()
      assert {:error, %Ecto.Changeset{}} = Downloads.update_download(download, @invalid_attrs)
      assert download == Downloads.get_download!(download.id)
    end

    test "delete_download/1 deletes the download" do
      download = download_fixture()
      assert {:ok, %Download{}} = Downloads.delete_download(download)
      assert_raise Ecto.NoResultsError, fn -> Downloads.get_download!(download.id) end
    end

    test "change_download/1 returns a download changeset" do
      download = download_fixture()
      assert %Ecto.Changeset{} = Downloads.change_download(download)
    end
  end
end
