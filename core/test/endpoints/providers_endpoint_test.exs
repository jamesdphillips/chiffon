defmodule Cake.ProvidersEndpointTest do
  use ShouldI
  use Plug.Test
  alias Cake.ProvidersEndpoint, as: Subject

  @opts Subject.init([])

  should "call provider plugs" do
    conn = conn(:get, "/hello")
    conn = Subject.call(conn, @opts)
    assert conn.__struct__ == Plug.Conn
  end
end
