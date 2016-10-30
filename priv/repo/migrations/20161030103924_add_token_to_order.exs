defmodule ShoppingSite.Repo.Migrations.AddTokenToOrder do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      add :token, :string
    end
    create index(:orders, [:token])

  end
end
