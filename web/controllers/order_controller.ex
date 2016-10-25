defmodule ShoppingSite.OrderController do
  use ShoppingSite.Web, :controller

  require Logger
  alias ShoppingSite.Order
  alias ShoppingSite.OrderInfo
  #alias ShoppingSite.Cart
  alias ShoppingSite.Repo

  import ShoppingSite.UserController, only: [authenticate: 2]
  import ShoppingSite.CartController, only: [current_cart: 1]
  plug :authenticate when action in [:create]



  def create(conn, %{"order" => order_params}) do

    new_order_params =
      order_params
        |> Map.put(:user_id, conn.assigns.current_user.id)
        |> Map.put(:total, get_total_price(conn))

    order_info_changeset = OrderInfo.changeset(%OrderInfo{}, order_params["info"])
    order_changeset = Order.changeset(%Order{info: order_info_changeset}, new_order_params)

    if order_changeset.valid? do
      # Logger.debug "validddddd"
      case Repo.insert(order_changeset) do
        {:ok, _order} ->
          conn
          |> put_flash(:info, "Order created successfully.")
          |> redirect(to: cart_path(conn, :index))
        {:error, order_changeset} ->
          render(conn, "index.html", changeset: order_changeset)
      end
    else
      # Logger.debug "not  validddddd"
      conn
        |> put_flash(:warning, "something wrong")
        |> redirect(to: cart_path(conn, :index))
    end
  end


  def get_total_price(conn) do
    Repo.preload(current_cart(conn), :cart_items).cart_items
      |> Repo.preload(:product)
      |> Enum.map(& &1.product.price)
      |> Enum.sum
  end

  def build_item_cache(conn) do

    products =
      Repo.preload(current_cart(conn), :cart_items).cart_items
        |> Repo.preload(:product)
        |> Enum.map(& &1.product)

    for item <- products do

    end

  end

end
