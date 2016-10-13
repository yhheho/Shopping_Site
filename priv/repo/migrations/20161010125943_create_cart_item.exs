defmodule ShoppingSite.Repo.Migrations.CreateCartItem do
  use Ecto.Migration

  def change do
    create table(:cart_items) do
      #add :cart_id, :integer
      #add :product_id, :integer

      timestamps()
    end

  end
end
