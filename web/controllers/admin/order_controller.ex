defmodule ShoppingSite.Admin.OrderController do
  use ShoppingSite.Web, :controller

  import ShoppingSite.UserController, only: [authenticate: 2]
  import ShoppingSite.Auth, only: [admin_required: 2]
  plug :authenticate
  plug :admin_required

  def index(conn, _params) do
    query = from x in ShoppingSite.Order, preload: [:user]
    orders =
      Repo.all(query)
    render conn, "index.html", orders: orders
  end
end
