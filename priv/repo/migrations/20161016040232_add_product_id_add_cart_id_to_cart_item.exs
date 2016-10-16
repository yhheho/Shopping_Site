defmodule ShoppingSite.Repo.Migrations.AddProductIdAddCartIdToCartItem do
  use Ecto.Migration

  def change do
    alter table(:cart_items) do
      add :cart_id, references(:carts)
      add :product_id, references(:products)
    end
  end
end
