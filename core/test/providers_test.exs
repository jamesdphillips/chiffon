defmodule Cake.ProvidersTest do
  use ShouldI
  alias Cake.Providers
  require Providers

  defmodule Cake.Providers.TestProvider.Plug do
    def init(conf), do: conf
    def call(c, _), do: c
  end

  defmodule Cake.Providers.TestDoesNotImplementCall.Plug do
    # ...
  end

  defmodule Cake.Providers.TestProvider.IShouldNotBeIncluded do
    def call(_, _), do: nil
  end

  should "return all providers" do
    assert Providers.all_plugs |> Enum.member?(Cake.Providers.TestProvider.Plug)
  end

  should "not include modules that are not named plug" do
    assert !(Providers.all_plugs |> Enum.member?(Cake.Providers.TestProvider.IShouldNotBeIncluded))
  end

  should "not include modules that do not implement call/2" do
    assert !(Providers.all_plugs |> Enum.member?(Cake.Providers.TestDoesNotImplementCall.Plug))
  end
end
