defmodule CorpHanger.Router do
  use CorpHanger.Web, :router

  pipeline :browser do
    plug Ueberauth
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CorpHanger do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/locations", LocationController, only: [:show]
  end

  scope "/auth", CorpHanger do
    pipe_through :browser

    delete "/logout", AuthController, :delete

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end

  # Other scopes may use custom stacks.
  # scope "/api", CorpHanger do
  #   pipe_through :api
  # end
end
