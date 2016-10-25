defmodule ShoppingSite.CartView do
  use ShoppingSite.Web, :view

  alias ShoppingSite.Cart
  alias ShoppingSite.Repo

  import ShoppingSite.CartController, only: [current_cart: 1]

  def cart_total_price(conn) do
    # cart_id = Plug.Conn.get_session(conn, :cart_id)
    # current_cart = ShoppingSite.Repo.get!(Cart, cart_id)

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

  def get_current_cart(conn) do
    # cart_id = Plug.Conn.get_session(conn, :cart_id)
    # Repo.get(Cart, cart_id)
    conn
      |> current_cart
  end

  def get_cart_items(conn) do
    # current_cart = get_current_cart(conn)
    products =
      Repo.preload(current_cart(conn), :products).products
  end

end
