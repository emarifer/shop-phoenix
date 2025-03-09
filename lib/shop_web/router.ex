defmodule ShopWeb.Router do
  use ShopWeb, :router

  alias ShopWeb.Plugs

  pipeline :browser do
    # The pipeline can now accept both HTML and JSON
    plug :accepts, ["html", "json"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ShopWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Plugs.SetConsole, "PC"
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # pipeline :auth do
  #   plug Plugs.EnsureAuthenticated
  # end

  scope "/", ShopWeb do
    pipe_through :browser

    get "/", PageController, :home
    # This route, along with the GET verb, will assign
    # the `ProductController` controller with the `index` action,
    # which can render both HTML and JSON.
    # The special Phoenix query parameter (`?_format=json`) allows us
    # to differentiate between the two requests.
    # But the ideal is to have a separate scope with
    # separate controllers and separate actions.
    get "/products", ProductController, :index
    get "/products/:slug", ProductController, :show
    get "/random", RandomController, :random

    # Resources:
    # resources "/products", ProductController, only: [:index, :show]
    # resources "/products", ProductController, except: [:delete]

    # Nested resources:
    # resources "/users", UserController do
    #   # resources "/posts", PostController
    #   get "/posts", PostController, :index
    # end
  end

  # Other scopes may use custom stacks.
  scope "/api", ShopWeb do
    pipe_through :api

    get "/products", ApiController, :index

    # `new` and `edit` refer to the rendering of forms for
    # creating and editing a resource, so this does
    # ↓↓↓ not make sense in a web API ↓↓↓
    resources "/promotions", PromotionController, except: [:new, :edit]
  end

  # scope "/dashboard", ShopWeb do
  #   pipe_through [:browser, :auth]

  #   get "/", DashboardController, :index
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:shop, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ShopWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end

# API routes:
# mix phx.routes | grep promotions ==>
#   GET     /api/promotions       ShopWeb.PromotionController :index
#   GET     /api/promotions/:id   ShopWeb.PromotionController :show
#   POST    /api/promotions       ShopWeb.PromotionController :create
#   PATCH   /api/promotions/:id   ShopWeb.PromotionController :update
#   PUT     /api/promotions/:id   ShopWeb.PromotionController :update
#   DELETE  /api/promotions/:id   ShopWeb.PromotionController :delete
