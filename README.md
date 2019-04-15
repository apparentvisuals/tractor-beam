# Tractor Beam

## Requirements
- Erlang VM
- Elixir

Optional:
- NodeJS 8+

## Running the server

### Setup

1. Add `config/dev.secret.exs` file
    ``` 
    use Mix.Config
    config :tractor_beam, TractorBeam.Indexers.NZBGeek,
      api_key: "<nzb_geek_api_key>"
    config :tractor_beam, TractorBeam.Metadata.OMDB,
      api_key: "<OMDB_api_key>"
    config :tractor_beam, TractorBeam.Metadata.TMDB,
      api_key: "<TMDB_api_key>"
    ```
2. Install dependencies with `mix deps.get`
3. If this is the first time, create and migrate your database with `mix ecto.setup`
4. Start Phoenix endpoint with `mix phx.server`
5. Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Web client
The repo has the latest UI code pre-compiled under `priv/static`, to work on the web-client nodeJS is required.

### Setup

1. `cd web-client`
2. `npm install`
3. `npm run dev`
4. Now you can visit [`localhost:3000`](http://localhost:3000) from your browser. The web-client proxies api requests to the server at port 4000, so both need to be running when developing client code.
