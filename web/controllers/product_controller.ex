defmodule ShoppingSite.ProductController do
  use ShoppingSite.Web, :controller

  alias ShoppingSite.Product
  alias ShoppingSite.Repo
  alias ShoppingSite.CartItem

  import ShoppingSite.CartController, only: [current_cart: 1]

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

    cart_item_changeset =
      build_assoc(current_cart(conn), :cart_items)
        |> CartItem.changeset(%{"cart_id" => current_cart(conn).id, "product_id" => product.id})

    case Repo.insert(cart_item_changeset) do
      {:ok, _cart_item} ->
        conn
        |> put_flash(:info, "add to cart successfully.")
        |> redirect(to: product_path(conn, :show, product_id))
      {:error, _changeset} ->
        render(conn, "show.html")
    end
  end

end
