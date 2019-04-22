defmodule TractorBeam.Downloaders.SABNZBD do
  @api_key Application.get_env(:tractor_beam, TractorBeam.Downloaders.SABNZBD)[:api_key]
  @server_url Application.get_env(:tractor_beam, TractorBeam.Downloaders.SABNZBD)[:server_url]

  def add_url(url) do
    
  end
end