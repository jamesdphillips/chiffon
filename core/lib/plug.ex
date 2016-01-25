
defmodule Cake.Plug do
  @moduledoc """
  Plug & Guts of the operation

  * [x] Load all authentication providers
  * [ ] Token API
  * [ ] Lazily load configuration
  * [ ] Bake a cake
  """
  use Plug.Builder

  # @before_compile Cake.LoadProviderPlugs
  plug Cake.TokenEndpoint
  plug Cake.ProvidersEndpoint
end
