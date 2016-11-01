defmodule ShoppingSite.CartView do
  use ShoppingSite.Web, :view

  alias ShoppingSite.Repo

  import ShoppingSite.CartController, only: [current_cart: 1]

  def cart_total_price(conn) do
    Repo.preload(current_cart(conn), :cart_items).cart_items
      |> Repo.preload(:product)
      |> Enum.map(& &1.product.price)
      |> Enum.sum
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

end
