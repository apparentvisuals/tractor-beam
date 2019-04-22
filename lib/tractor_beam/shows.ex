defmodule TractorBeam.Shows do
  @moduledoc """
  The Shows context.
  """

  import Ecto.Query, warn: false
  import Ecto.Changeset
  alias TractorBeam.Repo
  alias TractorBeam.Shows.Show
  alias TractorBeam.Metadata.TMDB

  @doc """
  Returns the list of shows.

  ## Examples

      iex> list_shows()
      [%Show{}, ...]

  """
  def list_shows do
    Repo.all(Show)
  end

  @doc """
  Gets a single show.

  Raises `Ecto.NoResultsError` if the Show does not exist.

  ## Examples

      iex> get_show!(123)
      %Show{}

      iex> get_show!(456)
      ** (Ecto.NoResultsError)

  """
  def get_show!(id), do: Repo.get!(Show, id)

  @doc """
  Creates a show.

  ## Examples

      iex> create_show(%{field: value})
      {:ok, %Show{}}

      iex> create_show(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_show(attrs \\ %{}) do
    %Show{}
    |> Show.changeset(attrs)
    |> put_metadata(attrs)
    |> Repo.insert()
  end

  defp put_metadata(%Ecto.Changeset{valid?: true} = changeset, attrs) do
    item = changeset.changes
    case TMDB.detail(%{ type: item.type, id: item.external_id}) do
      {:ok, metadata} -> put_change(changeset, :imdb_id, metadata["imdb_id"])
      _ -> changeset
    end
  end

  defp put_metadata(%Ecto.Changeset{valid?: false} = changeset, attrs) do
    changeset
  end

  @doc """
  Updates a show.

  ## Examples

      iex> update_show(show, %{field: new_value})
      {:ok, %Show{}}

      iex> update_show(show, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_show(%Show{} = show, attrs) do
    show
    |> Show.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Show.

  ## Examples

      iex> delete_show(show)
      {:ok, %Show{}}

      iex> delete_show(show)
      {:error, %Ecto.Changeset{}}

  """
  def delete_show(%Show{} = show) do
    Repo.delete(show)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking show changes.

  ## Examples

      iex> change_show(show)
      %Ecto.Changeset{source: %Show{}}

  """
  def change_show(%Show{} = show) do
    Show.changeset(show, %{})
  end
end
