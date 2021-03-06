defmodule ShoppingSite.CartController do
  use ShoppingSite.Web, :controller

  require Logger

  alias ShoppingSite.Repo
  alias ShoppingSite.Order
  alias ShoppingSite.Cart
  alias ShoppingSite.OrderInfo

  import ShoppingSite.UserController, only: [authenticate: 2]
  plug :authenticate when action in [:check_out]

  def index(conn, _params) do
    # cart_items =
    #   Repo.preload(current_cart(conn), :cart_items).cart_items

    products =
      Repo.preload(current_cart(conn), :products).products

    render conn, "index.html", products: products
  end

  def check_out(conn, _params) do
    order_info_changeset = OrderInfo.changeset(%OrderInfo{})
    order_changeset = Order.changeset(%Order{info: order_info_changeset})
    render conn, "check_out.html", order_changeset: order_changeset
  end

  def clean(conn, _params) do
    # Repo.preload(current_cart(conn), :cart_items).cart_items
    #   |> Enum.map(& Repo.delete(&1))
    Cart.clean_cart_items(current_cart(conn))

    conn
      |> put_flash(:info, "Cart cleaned")
      |> redirect(to: cart_path(conn, :index))
  end

  def current_cart(conn) do
    conn.assigns.current_cart
  end

end
