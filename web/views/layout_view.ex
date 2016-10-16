defmodule ShoppingSite.LayoutView do
  use ShoppingSite.Web, :view

  require Logger
  # def current_user(conn) do
  #   conn.assigns[:current_cart]
  # end

  def cart_item_count(conn) do

    cart_id = Plug.Conn.get_session(conn, :cart_id)

    if cart_id do
      current_cart = ShoppingSite.Repo.get(ShoppingSite.Cart, cart_id)
      query =
      ShoppingSite.Repo.preload(current_cart, :cart_items).cart_items
        #|> ShoppingSite.Product.products_count
        #|> ShoppingSite.Repo.aggregate(:count, :id)
        |> length
      #ShoppingSite.Repo.all(query)

    else
      0
    end

    # if conn.assigns[:current_cart] do
    #   query = ShoppingSite.Product.products_count(conn)
    #   ShoppingSite.Repo.all(query)
    # else
    #   Logger.debug "NAVBAR cannot find cart"
    #   0
    # end
  end

end
