defmodule Fhub.Repo.Migrations.CreatePermissions do
  use Ecto.Migration

  def change do
    create table(:permissions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :can, {:array, :string}

      add :resource_id, references(:resources, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create index(:permissions, [:resource_id])
  end
end
