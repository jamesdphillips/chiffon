defmodule Cake.LoadProviderPlugs do
  @moduledoc """
  Similar to how Mix.Task loads all known tasks when it is run, this module
  pulls in all Authentication Providers at compile time; avoiding any cumbersome
  registry.
  """

  #@doc false
  # defmacro __before_compile__(_env) do
  #   Enum.map(Cake.Providers.all_plugs, fn(p) ->
  #     IO.inspect p
  #     quote do: plug unquote(p)
  #   end)
  # end
end
