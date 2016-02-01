defmodule Mix.Tasks.Cake.Gen.Migration do
  use Mix.Task
  import Mix.Generator
  import Mix.Ecto, only: [parse_repo: 1, ensure_repo: 2, migrations_path: 1]
  import Mix.Project, only: [app_path: 0]

  @shortdoc "Generate migrations for access tokens and revocations"

  @moduledoc """
  Generates migrations for access tokens and token revocations.

  ## Examples

  mix cake.gen.migrations
  mix cake.gen.migrations -r MyApp.Repo

  ## Command line options
  * `-r`, `--repo` - the repo to generate migration for (defaults to `YourApp.Repo`)
  """

  def run(args) do
    Enum.each parse_repo(args), fn repo ->
      ensure_repo(repo, args)
      path = Path.relative_to(migrations_path(repo), app_path)
      file = Path.join(path, "#{timestamp}_add_cake_auth_tables.exs")
      assigns = [mod: Module.concat([repo, Migrations, "AddCakeAuthTables"])]
      create_directory path
      create_file file, migration_template(assigns)
    end
  end

  # Taken directly from Ecto.Gen.Migration,
  # maybe should be in Ecto.Mix module instead.
  defp timestamp do
    {{y, m, d}, {hh, mm, ss}} = :calendar.universal_time()
    "#{y}#{pad(m)}#{pad(d)}#{pad(hh)}#{pad(mm)}#{pad(ss)}"
  end

  defp pad(i) when i < 10, do: << ?0, ?0 + i >>
  defp pad(i), do: to_string(i)

  # TODO: Revocations
  # TODO: Expire? http://www.the-art-of-web.com/sql/trigger-delete-old/
  embed_template :migration, """
  defmodule <%= inspect @mod %> do
    use Ecto.Migration

    @expiry 3_600 # 1 hour
    @prefix Application.get_env(:cake, :table_prefix)

    def change do
      token_table_name = @prefix <> "tokens"
      # revocation_table_name = @prefix <> "revocations"

      create table(token_table_name, primary_key: false) do
        add :access_token,  :string, size: 32
        add :refresh_token, :string, size: 32
        add :issued_at,     :datetime
        add :expires_in,    :integer, default: @expiry
      end

      create index(table_name, [:access_token])
      create index(table_name, [:refresh_token])
    end
  end
  """
end
