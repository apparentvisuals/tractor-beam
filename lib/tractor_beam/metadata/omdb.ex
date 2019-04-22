defmodule TractorBeam.Metadata.OMDB do
  @api_key Application.get_env(:tractor_beam, TractorBeam.Metadata.OMDB)[:api_key]
  @url "https://www.omdbapi.com"

  alias TractorBeam.Search.SearchQuery

  def capabilities() do
    [:movie]
  end

  def search(%SearchQuery{} = query) do
    HTTPoison.get!("#{@url}?apikey=#{@api_key}&s=#{query.query}").body
    |> Jason.decode
  end
end