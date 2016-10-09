defmodule ShoppingSite.Router do
  use ShoppingSite.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug ShoppingSite.Auth, repo: ShoppingSite.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ShoppingSite do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController, only: [:index, :show, :new, :create]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  scope "/admin", ShoppingSite.Admin, as: :admin do
    pipe_through :browser

    resources "/products", ProductController
    resources "/users", UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", ShoppingSite do
  #   pipe_through :api
  # end
end
