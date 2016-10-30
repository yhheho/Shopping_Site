defmodule ShoppingSite.Router do
  use ShoppingSite.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug ShoppingSite.Auth, repo: ShoppingSite.Repo
    plug ShoppingSite.CartPlug
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ShoppingSite do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController, only: [:index, :show, :new, :create]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    resources "/products", ProductController, only: [:index, :show] do
      get "/add_to_cart", ProductController, :add_to_cart, as: :add_to_cart
    end

    resources "/carts", CartController, only: [:index] do
      get "/check_out", CartController, :check_out, as: :check_out
    end

    resources "/orders", OrderController, param: "token"
  end

  scope "/admin", ShoppingSite.Admin, as: :admin do
    pipe_through :browser

    resources "/products", ProductController

    resources "/users", UserController

    get "/change_authority/:id",  UserController, :change_authority
    get "/products_list_view", ProductController, :list_view
  end

  # Other scopes may use custom stacks.
  # scope "/api", ShoppingSite do
  #   pipe_through :api
  # end
end
