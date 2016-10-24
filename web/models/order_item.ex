defmodule ShoppingSite.OrderItem do
  use ShoppingSite.Web, :model

  schema "order_items" do
    field :product_name, :string
    field :price, :integer
    field :quantity, :integer
    belongs_to :order, ShoppingSite.Order

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:product_name, :price, :quantity])
    |> validate_required([:product_name, :price, :quantity])
  end
end
