defmodule PhoenixCrud.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :content, :text
      add :title, :string
      add :user_id, references(:users)

      timestamps
    end
    create index(:posts, [:user_id])

  end
end
