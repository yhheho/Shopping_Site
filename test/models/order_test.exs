defmodule ShoppingSite.OrderTest do
  use ShoppingSite.ModelCase

  alias ShoppingSite.Order

  @valid_attrs %{total: 42, user_id: 42}
  @invalid_attrs %{}

  # test "changeset with valid attributes" do
  #   changeset = Order.changeset(%Order{}, @valid_attrs)
  #   assert changeset.valid?
  # end

  # test "changeset with invalid attributes" do
  #   changeset = Order.changeset(%Order{}, @invalid_attrs)
  #   refute changeset.valid?
  # end
end
