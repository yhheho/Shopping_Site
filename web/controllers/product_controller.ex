defmodule ShoppingSite.ProductController do
  use ShoppingSite.Web, :controller

  alias ShoppingSite.Product

  def index(conn, _params) do
    products = Repo.all(Product)
    render conn, "index.html", products: products
  end

  def show(conn, %{"id" => id}) do
    product = Repo.get(ShoppingSite.Product, id)
    render conn, "show.html", product: product
  end



end
