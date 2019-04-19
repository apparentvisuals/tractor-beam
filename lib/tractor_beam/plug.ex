defmodule TractorBeam.Plug do
  defmodule Auth do
    @api_key Application.get_env(:tractor_beam, TractorBeam.Plug.Auth)[:api_key]
    use Plug.Builder

    plug :verify_key

    def verify_key(conn, _opts) do
      case get_req_header(conn, "authorization") do
        ["Bearer " <> @api_key] -> conn
        _ -> unauthorized(conn)
      end
    end

    def unauthorized(conn) do
      conn
      |> send_resp(401, "unauthorized")
      |> halt()
    end
  end

  defmodule IndexHtml do
    @behaviour Plug

    @doc false
    def init([]), do: init(at: "/")
    def init(at: path), do: init(at: path, default_file: "index.html")

    def init(at: path, default_file: filename) do
      path_no_slash = String.trim_trailing(path, "/")
      [matcher: ~r|^#{path_no_slash}(.*/)?$|, default_file: filename]
    end

    @doc false
    def call(conn, matcher: pattern, default_file: filename) do
      if String.match?(conn.request_path, pattern) do
        %{
          conn
          | request_path: "#{conn.request_path}#{filename}",
            path_info: conn.path_info ++ [filename]
        }
      else
        conn
      end
    end
  end
end
