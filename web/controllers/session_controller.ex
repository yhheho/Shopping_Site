defmodule ShoppingSite.SessionController do
  use ShoppingSite.Web, :controller

  def new(conn, _params) do
    render conn, "new.html"
  end

  def delete(conn, _params) do
    conn
    |> ShoppingSite.Auth.logout
    |> redirect(to: page_path(conn, :index))
  end

  def create(conn, %{"session" => %{"username" => username_passed, "password" => pass}}) do
    case ShoppingSite.Auth.login_by_username_and_pass(conn,
                                                      username_passed,
                                                      pass,
                                                      repo: Repo) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: page_path(conn, :index))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:info, "Invalid username/password")
        |> render("new.html")
    end
  end

end
