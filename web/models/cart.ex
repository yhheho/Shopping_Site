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

  @doc """
  debug session
  alias ShoppingSite.Repo
  alias ShoppingSite.Cart
  cart = Repo.get Cart, 33
  products_in_cart = Repo.all Ecto.assoc(cart, :products)
  products_in_cart |> Enum.any?(& &1.id == 16)
  """


end
