defmodule Cake.PlugUtils do
  @moduledoc """
  General Plug utility functions

  Stopped into a church
  I passed a long the way
  Well I got down on my knees
  And I pretend to pray ...
  """

  @doc """
  Specify more than one plug in a builder.

  Usage:

  ```elixir
  plug :confectionary # existing macro
  plugs [ :black, :white ] # Load enumerable
  ```
  """
  defmacro plugs(plugs, opts \\ []) do
    Enum.map(plugs, fn (pl) ->
      quote do: plug(unquote(pl), unquote(opts))
    end)
  end
end
