defmodule ShoppingSite.Repo.Migrations.CreateCartItem do
  use Ecto.Migration

  def change do
    create table(:cart_items) do
      #add :cart_id, references(:cart)
      #add :product_id, references(:products)

      timestamps()
    end

  end
end
