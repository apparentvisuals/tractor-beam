defmodule TractorBeam.Metadata.TMDB do
  @api_key Application.get_env(:tractor_beam, TractorBeam.Metadata.TMDB)[:api_key]
  @url "https://api.themoviedb.org/3"
  @poster_url "https://image.tmdb.org/t/p/w154"

  alias TractorBeam.SearchQuery

  def api_url() do
    @url
  end

  def capabilities() do
    ["tv", "movie"]
  end

  def search(%SearchQuery{} = query) do
    Task.async(fn -> _search(query) end)
    |> Task.await(145000)
  end

  defp _search(%SearchQuery{type: type, name: name, page: page} = _query) do
    HTTPoison.get!("#{api_url()}/search/#{type}", [], params: %{api_key: @api_key, query: name, page: page}).body
    |> Jason.decode
    |> response_to_common_format(type)
  end

  def response_to_common_format({:ok, results} = _response, type) do
    {:ok, %{page: results["page"],
      pages: results["total_pages"],
      total: results["total_results"],
      data: Enum.map(results["results"], &result_to_common_format(&1, type))}}
  end

  def result_to_common_format(result, "tv" = _type) do
    %{id: result["id"],
      title: result["name"],
      original_title: result["original_name"],
      summary: result["overview"],
      poster_url: "#{@poster_url}#{result["poster_path"]}"}
  end

  def result_to_common_format(result, "movie" = _type) do
    %{id: result["id"],
      title: result["title"],
      summary: result["overview"],
      poster_url: "#{@poster_url}#{result["poster_path"]}"}
  end

end