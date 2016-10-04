defmodule ShoppingSite.Repo.Migrations.AlterUsers2 do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :account
    end
  end
end
