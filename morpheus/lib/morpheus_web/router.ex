defmodule MorpheusWeb.Router do
  use MorpheusWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MorpheusWeb do
    pipe_through :api
    resources "/products", ProductController, except: [:new, :edit]
  end

  scope "/api/swagger" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI, otp_app: :morpheus, swagger_file: "swagger.json"
  end

  def swagger_info do
    %{
      info: %{
        version: "1.0",
        title: "Morpheus"
      }
    }
  end
end
