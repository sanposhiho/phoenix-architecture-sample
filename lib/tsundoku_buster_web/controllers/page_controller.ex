defmodule TsundokuBusterWeb.PageController do
  use TsundokuBusterWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
