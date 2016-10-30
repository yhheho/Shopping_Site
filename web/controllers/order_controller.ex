defmodule ShoppingSite.OrderController do
  use ShoppingSite.Web, :controller

  require Logger
  require IEx
  alias ShoppingSite.Order
  alias ShoppingSite.OrderInfo
  alias ShoppingSite.OrderItem
  alias ShoppingSite.Repo

  import ShoppingSite.UserController, only: [authenticate: 2]
  import ShoppingSite.CartController, only: [current_cart: 1]
  plug :authenticate when action in [:create]



  def create(conn, %{"order" => order_params}) do

    new_order_params =
      order_params
        |> Map.put("user_id", Integer.to_string(conn.assigns.current_user.id))
        |> Map.put("total", Integer.to_string(get_total_price(conn)))
        # |> Map.put("is_paid", "false")

    order_changeset =
      Order.changeset(%Order{}, new_order_params)

    if order_changeset.valid? do
      case Repo.insert(order_changeset) do
        {:ok, order} ->
          build_order_item(conn, order)
          conn
            |> put_flash(:info, "Order created successfully.")
            |> redirect(to: cart_path(conn, :index))
        {:error, order_changeset} ->
          render(conn, "index.html", changeset: order_changeset)
      end
    else
      conn
        |> put_flash(:warning, "something wrong")
        |> redirect(to: cart_path(conn, :index))
    end
  end

  def show(conn, %{"token" => token}) do
    order = Repo.get_by(Order, token: token)
    order_info = Repo.preload(order, :info).info
    order_items = Repo.preload(order, :items).items
    render conn, "show.html", order: order, order_info: order_info, order_items: order_items
  end

  def pay_with_credit_card(conn, %{"order_token" => token}) do
    order = Repo.get_by(Order, token: token)
    set_payment_method(order, "credit_card")
    set_paid(order)

    conn
      |> put_flash(:info, "Paid successfully!")
      |> redirect(to: order_path(conn, :show, order.token))
  end

  def get_total_price(conn) do
    Repo.preload(current_cart(conn), :cart_items).cart_items
      |> Repo.preload(:product)
      |> Enum.map(& &1.product.price)
      |> Enum.sum
  end

  def build_order_item(conn, order) do
    # need to build item_cache for every order
    # because when the order is confirmed, the cart is empty
    # we cannot retrive product from cart anymore

    products =
      Repo.preload(current_cart(conn), :cart_items).cart_items
        |> Repo.preload(:product)
        |> Enum.map(& &1.product)

    for item <- products do
      order_item_changeset =
        build_assoc(order, :items)
          |> OrderItem.changeset(%{"product_name" => item.title,
                                   "price" => item.price, "quantity" => 1})

      case Repo.insert(order_item_changeset) do
        {:ok, _order_item} ->
          conn
        {:error, _changeset} ->
          render(conn, "show.html")
      end
    end
  end

  def set_payment_method(order, method) do
    Ecto.Changeset.change(order, %{payment_method: method})
      |> Repo.update
  end

  def set_paid(order) do
    Ecto.Changeset.change(order, %{is_paid: true})
      |> Repo.update
  end

end
