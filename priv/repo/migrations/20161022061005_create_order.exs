defmodule ShoppingSite.Repo.Migrations.CreateOrder do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :user_id, references(:users)
      add :total, :integer, default: 0

      timestamps()
    end

  end
end
