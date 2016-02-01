defmodule Mix.Tasks.Cake.Gen.MigrationTest do
  use ExUnit.Case, async: true
  import Mix.Tasks.Cake.Gen.Migration, only: [run: 1]

  tmp_path =
    Path.expand("../../tmp", __DIR__)
    |> Path.join(inspect(Cake.Gen.Migrations))
  @migrations_path Path.join(tmp_path, "migrations")

  defmodule Repo do
    def __adapter__, do: true # > Ecto 1.2
    def __repo__, do: true

    def config do
      [priv: "tmp/#{inspect(Cake.Gen.Migrations)}", otp_app: :cake]
    end
  end

  setup do # Clean up the directory
    on_exit fn -> File.rm_rf!(unquote(tmp_path)) end
    :ok
  end

  test "generate a new migration" do
    run ["-r", to_string(Repo)]
    assert [name] = File.ls!(@migrations_path)
    assert String.match? name, ~r/^\d{14}_add_cake_auth_tables/
  end
end
