defmodule LandingPageWeb.Router do
  use LandingPageWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LandingPageWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", LandingPageWeb do
    pipe_through(:api)

    scope "/v1", V1 do
      post("/leads", LeadController, :create)
    end
  end
end
