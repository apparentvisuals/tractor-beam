defmodule TractorBeamWeb.Router do
  use TractorBeamWeb, :router
  alias TractorBeam.Plug.Auth

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authorized do
    plug Auth
  end

  scope "/api", TractorBeamWeb do
    pipe_through [:api, :authorized]
    resources "/downloads", DownloadController
    resources "/search", SearchController, only: [:index, :show]
    resources "/shows", ShowController
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
