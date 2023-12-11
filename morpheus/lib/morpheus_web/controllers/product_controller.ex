defmodule MorpheusWeb.ProductController do
  use MorpheusWeb, :controller
  use PhoenixSwagger

  alias Morpheus.Products
  alias Morpheus.Products.Product

  action_fallback(MorpheusWeb.FallbackController)

  def swagger_definitions do
    %{
      Product:
        swagger_schema do
          title("Product")

          properties do
            id(:integer, "Product ID")
            title(:string, "Title of a product", required: true)
            description(:string, "Description of a product", required: true)
            image_url(:string, "Image url of a product", required: true)
          end

          example(%{
            id: 123,
            title: "Joe",
            description: "mama",
            image_url: "some_url.com"
          })
        end,
      ProductRequest:
        swagger_schema do
          title("ProductRequest")

          properties do
            title(:string, "Title of a product", required: true)
            description(:string, "Description of a product", required: true)
            image_url(:string, "Image url of a product", required: true)
          end

          example(%{
            title: "Joe",
            description: "mama",
            image_url: "some_url.com"
          })
        end
    }
  end

  swagger_path(:index) do
    get("/api/products")
    summary("List of Products")
    description("List all products in the database")
    produces("application/json")
    deprecated(false)

    response(200, "OK", Schema.ref(:Product),
      example: %{
        data: [
          %{
            id: 1,
            title: "Joe",
            description: "mama",
            image_url: "some_url.com"
          },
          %{
            id: 2,
            title: "Mama",
            description: "joe",
            image_url: "some_url.com"
          }
        ]
      }
    )
  end

  def index(conn, _params) do
    products = Products.list_products() |> Enum.reject(fn product -> product.is_deleted end)
    render(conn, :index, products: products)
  end

  swagger_path(:create) do
    post("/api/products")
    summary("Create product")
    description("Creates a new product")
    consumes("application/json")
    produces("application/json")

    parameter(:product, :body, Schema.ref(:ProductRequest), "The product details",
      example: %{
        user: %{title: "Joe", description: "Joe1@mail.com", image_url: "some_image.com"}
      }
    )

    response(201, "User created OK", Schema.ref(:Product),
      example: %{
        data: %{
          id: 1,
          title: "Joe",
          description: "Joe1@mail.com",
          image_url: "some_image.com"
        }
      }
    )
  end

  def create(conn, %{"product" => product_params}) do
    with {:ok, %Product{} = product} <- Products.create_product(product_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/products/#{product}")
      |> render(:show, product: product)
    end
  end

  swagger_path(:show) do
    summary("Show Product")
    description("Show a product by ID")
    produces("application/json")
    parameter(:id, :path, :integer, "Product ID", required: true, example: 123)

    response(200, "OK", Schema.ref(:Product),
      example: %{
        data: %{
          id: 1,
          title: "Joe",
          description: "mama",
          image_url: "some_url.com"
        }
      }
    )
  end

  def show(conn, %{"id" => id}) do
    case Products.get_product(id) do
      {:ok, product} ->
        render(conn, :show, product: product)

      {:error, :deleted} ->
        conn |> put_status(:not_found) |> json("Item has been deleted")

      _ ->
        conn |> put_status(:not_found)
    end
  end

  swagger_path(:update) do
    put("/api/products/{id}")
    summary("Update product")
    description("Update all attributes of a product")
    consumes("application/json")
    produces("application/json")

    parameters do
      id(:path, :integer, "Product ID", required: true, example: 3)

      user(:body, Schema.ref(:ProductRequest), "The product details",
        example: %{
          user: %{title: "Joe", description: "mama", image_url: "some_url.com"}
        }
      )
    end

    response(200, "Updated Successfully", Schema.ref(:Product),
      example: %{
        data: %{
          id: 1,
          title: "Joe",
          description: "mama",
          image_url: "some_url.com"
        }
      }
    )
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    case Products.update_product(id, product_params) do
      {:ok, product} ->
        render(conn, :show, product: product)

      {:error, :deleted} ->
        conn |> put_status(:not_found) |> json("Item has been deleted")

      _ ->
        conn |> put_status(:not_found)
    end
  end

  swagger_path(:delete) do
    PhoenixSwagger.Path.delete("/api/products/{id}")
    summary("Delete Product")
    description("Delete a product by ID")
    parameter(:id, :path, :integer, "Product ID", required: true, example: 3)
    response(203, "No Content - Deleted Successfully")
  end

  def delete(conn, %{"id" => id}) do
    case Products.get_product(id) do
      {:ok, product} ->
        with {:ok, %Product{}} <- Products.delete_product(product) do
          send_resp(conn, :no_content, "")
        end

      {:error, :deleted} ->
        conn |> put_status(:not_found) |> json("Item has been deleted")

      _ ->
        conn |> put_status(:not_found)
    end
  end
end
