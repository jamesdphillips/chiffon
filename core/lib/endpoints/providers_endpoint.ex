defmodule Cake.ProvidersEndpoint do
  @behaviour Plug
  @moduledoc """
  Providers Endpoint

  Loads and routes any traffic to provider endpoints
  """

  # NOTE: Loads all providers at compile time and configure routes
  # TODO: Determine if there is a cleaner way to accomplish this
  defmodule LoadProviders do
    @moduledoc false

    @doc false
    defmacro __before_compile__(env) do
      plugs = Cake.Providers.all_plugs |> Enum.map(fn (p) -> {p, [], true} end)
      {conn, body} = Plug.Builder.compile(env, plugs, [])

      quote do
        defp plug_builder_call(unquote(conn), _), do: unquote(body)
      end
    end
  end

  import Plug.Builder, only: [compile: 3]
  @before_compile LoadProviders

  def init(opts), do: opts
  def call(conn, opts), do: plug_builder_call(conn, opts)
end
