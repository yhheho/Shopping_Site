defmodule ShoppingSite.CartItemController do
  use ShoppingSite.Web, :controller

  alias ShoppingSite.Repo

  require IEx

  import ShoppingSite.UserController, only: [authenticate: 2]
  import ShoppingSite.CartController, only: [current_cart: 1]
  plug :authenticate when action in [:delete]

  def delete(conn, %{"id" => id}) do
    #we pass product's id from templates

    cart = current_cart(conn)

    # we want to delete the cart_item whose product_id is id

    cart_item =
      Repo.preload(cart, :cart_items).cart_items
        |> Enum.find(fn x -> x.product_id == String.to_integer(id) end)

    product =
      Repo.get(ShoppingSite.Product, id)

    Repo.delete!(cart_item)

    conn
      |> put_flash(:info, "Delete #{product.title} successfully.")
      |> redirect(to: cart_path(conn, :index))
  end

end
