defmodule ShoppingSite.Account.OrderController do
  use ShoppingSite.Web, :controller

  import ShoppingSite.UserController, only: [authenticate: 2]
  plug :authenticate #when action in [:index, :show]

  def index(conn, _params) do
    user =
      conn.assigns.current_user
        |> ShoppingSite.Repo.preload(:orders)

    orders =
      user.orders
        |> Enum.sort(& (&1.inserted_at > &2.inserted_at))
        # |> Enum.sort(fn d1, d2 ->
        #     case Ecto.DateTime.compare(d1, d2) do
        #      :gt -> true
        #      :eq -> true
        #      :ls -> false
        #     end
        #   end)
    render conn, "index.html", orders: orders
  end

end
