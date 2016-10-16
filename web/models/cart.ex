defmodule ShoppingSite.Cart do
  use ShoppingSite.Web, :model

  schema "carts" do

    has_many :cart_items, ShoppingSite.CartItem, on_delete: :delete_all
    has_many :products, through: [:cart_items, :product]

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [])
    |> validate_required([])
  end

  def add_product_to_cart(product) do

  end
end
