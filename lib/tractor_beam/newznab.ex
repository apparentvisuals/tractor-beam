defmodule TractorBeam.Newznab do
  @api_key Application.get_env(:tractor_beam, TractorBeam.Indexers.NZBGeek)[:api_key]

  import SweetXml

  def supported?(value) do
    value == "yes"
  end

  def param_list(value) do
    String.split(value, ",")
  end

  def get_capabilities(url) do
    HTTPoison.get!("#{url}/api?t=caps").body
    |> convert_xml_to_indexer
  end
  
  def convert_xml_to_indexer(body) do
    body |> xpath(
      ~x"//caps",
      functions: [
        ~x"./searching",
        search: [
          ~x"./search", 
          available: ~x"./@available"s |> transform_by(&supported?/1),
          params: ~x"./@supportedParams"s |> transform_by(&param_list/1)
        ],
        tv_search: [
          ~x"./tv-search",
          available: ~x"./@available"s |> transform_by(&supported?/1),
          params: ~x"./@supportedParams"s |> transform_by(&param_list/1)
        ],
        movie_search: [
          ~x"./movie-search",
          available: ~x"./@available"s |> transform_by(&supported?/1),
          params: ~x"./@supportedParams"s |> transform_by(&param_list/1)
        ],
        audio_search: [
          ~x"./audio-search",
          available: ~x"./@available"s |> transform_by(&supported?/1),
          params: ~x"./@supportedParams"s |> transform_by(&param_list/1)
        ]
      ]
      # categories: [
      #   ~x"//categories/category"l,
      #   id: ~x"./@id"i,
      #   name: ~x"./@name"s,
      #   sub_categories: [
      #     ~x"./subcat"l,
      #     id: ~x"./@id"i,
      #     name: ~x"./@name"s
      #   ]
      # ]
    )
  end
end