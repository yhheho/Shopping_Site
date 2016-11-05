defmodule ShoppingSite.CartView do
  use ShoppingSite.Web, :view

  alias ShoppingSite.Repo
  import ShoppingSite.CartController, only: [current_cart: 1]

  def cart_total_price(conn) do

    Repo.preload(current_cart(conn), :cart_items).cart_items
      |> Repo.preload(:product)
      |> Enum.reduce(0, fn x, acc ->
            (x.product.price*x.quantity) + acc end)
  end

  def present?(photo) do
    photo.file_name != ""
  end

  def get_cart_id(conn) do
    Plug.Conn.get_session(conn, :cart_id)
  end

  def get_cart_items(conn) do
    products =
      Repo.preload(current_cart(conn), :products).products
  end

  def get_cart_item(conn, id) do
      Repo.preload(current_cart(conn), :cart_items).cart_items
        |> Enum.find(fn x -> x.product_id == id end)
  end

  def get_changeset(conn, product) do
    Repo.preload(current_cart(conn), :cart_items).cart_items
        |> Enum.find(fn x -> x.product_id == product.id end)
        |> ShoppingSite.CartItem.changeset(%{})
  end

  def get_selections() do
    [1, 2, 3, 4, 5]
  end

end
