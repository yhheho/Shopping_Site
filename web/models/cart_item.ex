defmodule ShoppingSite.CartItem do
  use ShoppingSite.Web, :model

  schema "cart_items" do
    #field :cart_id, :integer
    #field :product_id, :integer

    belongs_to :cart, ShoppingSite.Cart
    belongs_to :product, ShoppingSite.Product

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:cart_id, :product_id])
    |> validate_required([:cart_id, :product_id])
  end
end
