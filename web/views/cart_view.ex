defmodule ShoppingSite.CartView do
  use ShoppingSite.Web, :view

  require Logger
  alias ShoppingSite.Cart
  alias ShoppingSite.Repo

  def cart_total_price(conn) do
    cart_id = Plug.Conn.get_session(conn, :cart_id)
    current_cart = ShoppingSite.Repo.get!(Cart, cart_id)

    Repo.preload(current_cart, :products).products
      |> Enum.map(& &1.price)
      |> Enum.sum
  end

end
