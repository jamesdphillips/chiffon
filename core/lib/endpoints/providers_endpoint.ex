defmodule Cake.ProvidersEndpoint do
  @moduledoc """
  Providers Endpoint

  Loads and routes any traffic to provider endpoints
  """

  import Cake.Providers, only: [all_plugs: 0]

  @behaviour Plug

  def init(opts), do: opts
  def call(conn, opts) do
    Enum.reduce(all_plugs, {conn, opts}, &call_plug/2) |> elem(0)
  end

  defp call_plug(plug, {conn, opts}) do
    {plug.call(conn, opts), opts}
  end
end
