defmodule ShoppingSite.CartItemTest do
  use ShoppingSite.ModelCase

  alias ShoppingSite.CartItem

  @valid_attrs %{cart_id: 42, product_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = CartItem.changeset(%CartItem{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = CartItem.changeset(%CartItem{}, @invalid_attrs)
    refute changeset.valid?
  end
end
