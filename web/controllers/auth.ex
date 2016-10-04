defmodule ShoppingSite.Auth do
  import Plug.Conn
  import Phoenix.Controller
  alias Rumbl.Router.Helpers

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    user_id = get_session(conn, :user_id)
    user    = user_id && repo.get(ShoppingSite.User, user_id)
    assign(conn, :current_user, user)
  end

  defp authenticate(conn, _params) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must log in to access this page")
      |> redirect(to: page_path(conn, :index))
      |> halt
    end
  end
end
