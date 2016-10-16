defmodule ShoppingSite.PageController do
  use ShoppingSite.Web, :controller

  def index(conn, _params) do
    #ShoppingSite.CartController.find_cart(conn)
    render conn, "index.html"
  end
end
