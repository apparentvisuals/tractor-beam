defmodule TractorBeam.Metadata.TMDB do
  @api_key Application.get_env(:tractor_beam, TractorBeam.Metadata.TMDB)[:api_key]
  @url "https://api.themoviedb.org/3"

  def api_url() do
    @url
  end

  def capabilities() do
    ["tv", "movie"]
  end

  def search(%{type: type, name: name, page: page}) do
    HTTPoison.get!("#{api_url()}/search/#{type}", [], params: %{api_key: @api_key, query: name, page: page}).body
    |> Jason.decode
  end

  def detail(%{type: type, id: id}) do
    HTTPoison.get!("#{api_url()}/#{type}/#{id}", [], params: %{api_key: @api_key}).body
    |> Jason.decode
  end
end