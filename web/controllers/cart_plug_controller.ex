defmodule ShoppingSite.CartPlugController do
  import Plug.Conn
  alias ShoppingSite.Cart

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    if get_session(conn, :cart) do
      cart = repo.get(Cart, get_session(conn, :cart))
      assign(conn, :cart, cart)
    else
      changeset = Cart.changeset(%Cart{})
      case repo.insert(changeset) do
        {:ok, cart_created} ->
          conn
            |> put_session(:cart, cart_created.id)
            |> assign(:cart, cart_created)
        {:error, _} ->
          :error
      end
    end
  end
end
