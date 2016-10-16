defmodule ShoppingSite.ProductController do
  use ShoppingSite.Web, :controller

  # require Logger

  alias ShoppingSite.Product
  alias ShoppingSite.Repo
  alias ShoppingSite.CartItem

  def index(conn, _params) do
    products = Repo.all(Product)
    render conn, "index.html", products: products
  end

  def show(conn, %{"id" => id}) do
    product = Repo.get(ShoppingSite.Product, id)
    render conn, "show.html", product: product
  end

  def add_to_cart(conn, %{"product_id" => product_id}) do

    product = Repo.get(Product, product_id)
    cart_id = get_session(conn, :cart_id)
    current_cart = Repo.get(ShoppingSite.Cart, cart_id)

    cart_item_changeset =
      build_assoc(current_cart, :cart_items)
      |> CartItem.changeset(%{"cart_id" => current_cart.id, "product_id" => product.id})

    case Repo.insert(cart_item_changeset) do
      {:ok, _cart_item} ->
        conn
        |> put_flash(:info, "add to cart successfully.")
        |> redirect(to: product_path(conn, :index))
      {:error, _changeset} ->
        render(conn, "show.html")
    end
  end

end
