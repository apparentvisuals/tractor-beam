defmodule TractorBeam.Protocols.Newznab do
  defmacro __using__([]) do
    quote do
      import SweetXml

      def supported?(value) do
        value == "yes"
      end

      def param_list(value) do
        String.split(value, ",")
      end

      def capabilities() do
        HTTPoison.get!("#{api_url()}/api?t=caps").body
        |> parse_caps_xml
      end
      
      def search(name) do
        HTTPoison.get!("#{api_url()}/api?apikey=#{api_key()}&t=search&q=#{name}").body
        |> parse_search_xml
      end

      def search_imdb_id(id) do
        HTTPoison.get!("#{api_url()}/api?apikey=#{api_key()}&t=movie&imdbid=#{id}").body
        |> parse_search_xml
      end

      defp parse_search_xml(body) do
        body 
        |> xpath(
          ~x"//rss/channel",
          items: [
            ~x"./item"l,
            title: ~x"./title/text()"s,
            description: ~x"./description/text()"s,
            link: ~x"./link/text()"s
          ]
        )
      end

      defp parse_caps_xml(body) do
        body 
        |> xpath(
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
  end
end