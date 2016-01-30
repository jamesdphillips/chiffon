defmodule Cake.ProvidersTest do
  use ShouldI
  alias Cake.Providers

  should "return all providers" do
    assert Providers.all_plugs |> Enum.member?(Cake.Providers.Password.Plug)
  end

  should "not include modules that are not named plug" do
    assert !(Providers.all_plugs |> Enum.member?(Cake.Providers.Password.Record))
  end
end
