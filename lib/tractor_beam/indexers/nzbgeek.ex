defmodule TractorBeam.Indexers.NZBGeek do
  @config_key Application.get_env(:tractor_beam, TractorBeam.Indexers.NZBGeek)[:api_key]
  @newznab_url "https://api.nzbgeek.info"

  use TractorBeam.Protocols.Newznab

  def api_url do
    @newznab_url
  end
  
  def api_key do
    @config_key
  end
end