defmodule PhoenixCrud.Router do
  use PhoenixCrud.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope alias: PhoenixCrud do
    get "/", WelcomeController, :index, as: :root

    get "/pages/:page", PageController, :show, as: :page

    resources "users", UserController
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhoenixCrud do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhoenixCrud do
  #   pipe_through :api
  # end
end
