defmodule PhoenixCrud.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :bio, :string
      add :age, :integer

      timestamps
    end
  end
end
