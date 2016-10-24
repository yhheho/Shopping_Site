defmodule ShoppingSite.Repo.Migrations.CreateOrderInfo do
  use Ecto.Migration

  def change do
    create table(:order_infos) do
      add :billing_name, :string
      add :billing_address, :string
      add :shipping_name, :string
      add :shipping_address, :string
      add :order_id, references(:orders, on_delete: :nothing)

      timestamps()
    end
    create index(:order_infos, [:order_id])

  end
end
