defmodule PlaylistPal.Repo.Migrations.CreateTrack do
  use Ecto.Migration

  def change do
    create table(:tracks) do
      add :spotify_id, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:tracks, [:user_id])

  end
end
