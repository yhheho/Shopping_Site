defmodule ShoppingSite.LayoutView do
  use ShoppingSite.Web, :view

  require Logger
  # def current_user(conn) do
  #   conn.assigns[:current_cart]
  # end

  def cart_item_count(conn) do
    if conn.assigns[:current_cart] do
      query = ShoppingSite.Product.products_count(conn)
      ShoppingSite.Repo.all(query)
    else
      Logger.debug "NAVBAR cannot find cart"
      0
    end
  end

end
