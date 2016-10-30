defmodule ShoppingSite.Repo.Migrations.AddIsPaidToOrder do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      add :is_paid, :boolean, default: false
    end
  end
end
