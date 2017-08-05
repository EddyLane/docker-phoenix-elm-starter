defmodule PlaylistPal.Repo.Migrations.CreateEvent do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string
      add :user_id, references(:users, on_delete: :nothing, null: false)

      timestamps()
    end

    create index(:events, [:user_id])

  end
end
