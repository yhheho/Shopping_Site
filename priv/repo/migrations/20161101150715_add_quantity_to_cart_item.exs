defmodule ShoppingSite.Repo.Migrations.AddQuantityToCartItem do
  use Ecto.Migration

  def change do
    alter table(:cart_items) do
      add :quantity, :integer, default: 1
    end
  end
end
