defmodule ShoppingSite.LayoutView do
  use ShoppingSite.Web, :view

  require Logger

  def cart_item_count(conn) do

    cart_id = Plug.Conn.get_session(conn, :cart_id)

    if cart_id do
      current_cart = ShoppingSite.Repo.get(ShoppingSite.Cart, cart_id)
      ShoppingSite.Repo.preload(current_cart, :cart_items).cart_items
        |> length
    else
      0
    end
  end

end
