defmodule ExDbSeeds.Seed.SchemaSeed do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Query, only: [from: 2]

  @primary_key false
  schema "schema_seeds" do
    field(:version, :integer)
    timestamps(updated_at: false)
  end

  @opts [timeout: :infinity, log: false]

  def ensure_schema_seeds_table!(repo) do
    adapter = repo.__adapter__
    create_seeds_table(adapter, repo)
  end

  def seeded_versions(repo) do
    repo.all(from(p in {get_source(repo), __MODULE__}, select: p.version), @opts)
  end

  def up(repo, version) do
    repo.insert_all(
      {get_source(repo), __MODULE__},
      [
        %{
          version: version,
          inserted_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
        }
      ],
      @opts
    )
  end

  def down(repo, version) do
    repo.delete_all(
      from(p in {get_source(repo), __MODULE__}, where: p.version == ^version),
      @opts
    )
  end

  def get_source(repo) do
    Keyword.get(repo.config, :seed_source, "schema_seeds")
  end

  defp create_seeds_table(adapter, repo) do
    table_name = repo |> get_source |> String.to_atom()
    table = %Ecto.Migration.Table{name: table_name}

    # DDL queries do not log, so we do not need to pass log: false here.
    adapter.execute_ddl(
      repo,
      {:create_if_not_exists, table,
       [
         {:add, :version, :bigint, primary_key: true},
         {:add, :inserted_at, :naive_datetime, []}
       ]},
      @opts
    )
  end
end
