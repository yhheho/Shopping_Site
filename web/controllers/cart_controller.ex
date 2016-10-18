defmodule ShoppingSite.CartController do
  use ShoppingSite.Web, :controller

  require Logger

  alias ShoppingSite.Cart
  alias ShoppingSite.Repo


  def index(conn, _params) do
    cart_id = get_session(conn, :cart_id)
    current_cart = Repo.get!(Cart, cart_id)
    # cart_items =
    #   Repo.preload(current_cart, :cart_items).cart_items

    products =
      Repo.preload(current_cart, :products).products
    #Logger.debug cart_items |> length

    render conn, "index.html", cart_items: cart_items, products: products
  end



  # def current_cart(conn, _params) do
  #   cart_id = get_session(conn, :cart_id)

  #   if cart_id do
  #     cart = cart_id && Repo.get(Cart, cart_id)
  #     conn
  #       |> assign(:current_cart, cart)
  #   else
  #     cart = Repo.insert!(%Cart{})
  #     conn
  #       |> put_session(:cart_id, cart.id)
  #       |> assign(:current_cart, cart)
  #   end
  # end

  def find_cart(conn) do
    cart_id = get_session(conn, :cart_id)

    if cart_present?(cart_id) do
      Logger.debug "cart_id is present"
      case Repo.get!(Cart, cart_id) do
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
          |> put_flash(:error, "cart init error.")
    end
  end

  def cart_present?(res) do
    case res do
      nil -> false
      _   -> true
    end
  end

end
