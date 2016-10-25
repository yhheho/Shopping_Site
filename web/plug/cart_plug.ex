defmodule ShoppingSite.CartPlug do
  import Plug.Conn

  require Logger
  alias ShoppingSite.Repo
  alias ShoppingSite.Cart

  def init(default), do: default

  def call(conn, _params) do
    conn
      |> find_cart
  end

  def find_cart(conn) do
    cart_id = get_session(conn, :cart_id)

    if cart_present?(cart_id) do
      Logger.debug "cart_id is present"
      case Repo.get(Cart, cart_id) do
        nil ->
          conn
            |> create_cart

        cart ->
          conn
            |> put_session(:cart_id, cart.id)
            |> assign(:current_cart, cart)
      end
    else
      Logger.debug "cart_id is not present"
      conn
        |> create_cart
    end
  end

  def create_cart(conn) do
    changeset = Cart.changeset(%Cart{})
    case Repo.insert(changeset) do
      {:ok, cart} ->
        Logger.debug "created cart id = #{cart.id}"
        conn
          |> put_session(:cart_id, cart.id)
          |> assign(:current_cart, cart)
      {:error, _} ->
        conn
          # |> put_flash(:error, "cart init error.")
    end
  end

  def cart_present?(res) do
    case res do
      nil -> false
      _   -> true
    end
  end


end
