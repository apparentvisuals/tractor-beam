defmodule TractorBeamWeb.Router do
  use TractorBeamWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TractorBeamWeb do
    pipe_through :api
    resources "/downloads", DownloadController
    resources "/search", SearchController
  end

  def swagger_info do
    %{
      info: %{
        version: "1.0",
        title: "Tractor Beam"
      }
    }
  end
end
