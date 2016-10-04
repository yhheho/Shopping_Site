defmodule ShoppingSite.Admin.ProductController do
  use ShoppingSite.Web, :controller

  import ShoppingSite.UserController, only: [authenticate: 2]
  plug :authenticate #when action in [:index, :show]

  alias ShoppingSite.Product

  def index(conn, _params) do
    products = Repo.all(Product)
    render conn, "index.html", products: products
  end

  def show(conn, %{"id" => id}) do
    product = Repo.get(ShoppingSite.Product, id)
    render conn, "show.html", product: product
  end

  def new(conn, _params) do
    changeset = Product.changeset(%Product{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"product" => product_params}) do
    changeset = Product.changeset(%Product{}, product_params)

    case Repo.insert(changeset) do
      {:ok, product} ->
        conn
        |> put_flash(:info, "Add product successfully")
        |> redirect(to: page_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

end
