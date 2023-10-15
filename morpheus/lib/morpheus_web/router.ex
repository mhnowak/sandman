defmodule MorpheusWeb.Router do
  use MorpheusWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MorpheusWeb do
    pipe_through :api
  end
end
