defmodule ShoppingSite.Auth do
  import Plug.Conn
  import Phoenix.Controller
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    user_id = get_session(conn, :user_id)
    user    = user_id && repo.get(ShoppingSite.User, user_id)
    assign(conn, :current_user, user)
  end

  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  def logout(conn) do
    configure_session(conn, drop: true)
  end

  def login_by_username_and_pass(conn, username, pass, opts) do
    repo = Keyword.fetch!(opts, :repo)
    user = repo.get_by(ShoppingSite.User, username: username)

    cond do
      user && checkpw(pass, user.encrypted_password) ->
        {:ok, login(conn, user)}
      user ->
        {:error, :unauthorized, conn}
      true ->
        dummy_checkpw #prevent from timing attack lol
        {:error, :not_found, conn}
    end
  end

  def admin_required(conn, _params) do
    if conn.assigns.current_user.admin do
      conn
    else
      conn
        |> put_flash(:error, "You don't have this permission")
        |> redirect(to: ShoppingSite.Router.Helpers.page_path(conn, :index))
        |> halt
    end
  end

end
