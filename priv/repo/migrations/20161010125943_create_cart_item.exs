defmodule ShoppingSite.Repo.Migrations.CreateCartItem do
  use Ecto.Migration

  def change do
    create table(:cart_items) do

      timestamps()
    end

  end
end
