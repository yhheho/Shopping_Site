defmodule ShoppingSite.OrderInfoTest do
  use ShoppingSite.ModelCase

  alias ShoppingSite.OrderInfo

  @valid_attrs %{billing_address: "some content", billing_name: "some content", shipping_address: "some content", shipping_name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = OrderInfo.changeset(%OrderInfo{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = OrderInfo.changeset(%OrderInfo{}, @invalid_attrs)
    refute changeset.valid?
  end
end
