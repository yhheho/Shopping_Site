defmodule ShoppingSite.OrderItemTest do
  use ShoppingSite.ModelCase

  alias ShoppingSite.OrderItem

  @valid_attrs %{price: 42, product_name: "some content", quantity: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = OrderItem.changeset(%OrderItem{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = OrderItem.changeset(%OrderItem{}, @invalid_attrs)
    refute changeset.valid?
  end
end
