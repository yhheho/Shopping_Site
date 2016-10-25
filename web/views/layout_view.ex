defmodule ShoppingSite.LayoutView do
  use ShoppingSite.Web, :view

  require Logger
  import ShoppingSite.CartController, only: [current_cart: 1]

  def cart_item_count(conn) do
    ShoppingSite.Repo.preload(current_cart(conn), :cart_items).cart_items
      |> length
  end

end
