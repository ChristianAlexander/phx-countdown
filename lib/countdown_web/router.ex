defmodule CountdownWeb.Router do
  use CountdownWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {CountdownWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CountdownWeb do
    pipe_through :browser

    get "/", PageController, :home
    live "/timers", TimerLive.Index, :index
    live "/timers/new", TimerLive.Index, :new
    live "/timers/:id/edit", TimerLive.Index, :edit

    live "/timers/:id", TimerLive.Show, :show
    live "/timers/:id/show/edit", TimerLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", CountdownWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:countdown, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: CountdownWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
