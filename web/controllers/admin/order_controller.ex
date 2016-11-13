defmodule ShoppingSite.Admin.OrderController do
  use ShoppingSite.Web, :controller

  alias ShoppingSite.Order
  alias ShoppingSite.StateChangeController

  import ShoppingSite.UserController, only: [authenticate: 2]
  import ShoppingSite.Auth, only: [admin_required: 2]
  plug :authenticate
  plug :admin_required

  def index(conn, _params) do
    query = from x in Order, preload: [:user]
    orders =
      Repo.all(query)
    render conn, "index.html", orders: orders
  end

  def show(conn, %{"id" => id}) do
    order =
      Repo.get(Order, id)
        |> Repo.preload(:items)
        |> Repo.preload(:info)
    render conn, "show.html", order: order
  end

  def ship(conn, %{"order_id" => order_id}) do
    Repo.get(Order, order_id) #order
      |> StateChangeController.ship
    conn |> redirect(to: admin_order_path(conn, :show, order_id))
  end

  def shipped(conn, %{"order_id" => order_id}) do
    Repo.get(Order, order_id) #order
      |> StateChangeController.deliver
    conn |> redirect(to: admin_order_path(conn, :show, order_id))
  end

  def cancel(conn, %{"order_id" => order_id}) do
    Repo.get(Order, order_id) #order
      |> StateChangeController.cancell_order
    conn |> redirect(to: admin_order_path(conn, :show, order_id))
  end

  def return(conn, %{"order_id" => order_id}) do
    Repo.get(Order, order_id) #order
      |> StateChangeController.return_good
    conn |> redirect(to: admin_order_path(conn, :show, order_id))
  end
end
