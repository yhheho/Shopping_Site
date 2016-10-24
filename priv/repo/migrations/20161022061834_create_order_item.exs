defmodule ShoppingSite.Repo.Migrations.CreateOrderItem do
  use Ecto.Migration

  def change do
    create table(:order_items) do
      add :product_name, :string
      add :price, :integer
      add :quantity, :integer
      add :order_id, references(:orders, on_delete: :nothing)

      timestamps()
    end
    create index(:order_items, [:order_id])

  end
end
