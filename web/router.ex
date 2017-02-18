defmodule CorpHanger.Router do
  use CorpHanger.Web, :router

  pipeline :browser do
    plug Ueberauth
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CorpHanger do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/auth", CorpHanger do
    pipe_through :browser

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end

  # Other scopes may use custom stacks.
  # scope "/api", CorpHanger do
  #   pipe_through :api
  # end
end
