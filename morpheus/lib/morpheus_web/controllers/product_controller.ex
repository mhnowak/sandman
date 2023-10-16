defmodule MorpheusWeb.ProductController do
  use MorpheusWeb, :controller

  alias Morpheus.Products
  alias Morpheus.Products.Product

  action_fallback(MorpheusWeb.FallbackController)

  def index(conn, _params) do
    products = Products.list_products() |> Enum.reject(fn product -> product.is_deleted end)
    render(conn, :index, products: products)
  end

  def create(conn, %{"product" => product_params}) do
    with {:ok, %Product{} = product} <- Products.create_product(product_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/products/#{product}")
      |> render(:show, product: product)
    end
  end

  def show(conn, %{"id" => id}) do
    product = Products.get_product!(id)

    if product.is_deleted do
      conn |> put_status(:not_found) |> render(:item_deleted, product: product)
    else
      render(conn, :show, product: product)
    end
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    product = Products.get_product!(id)

    with {:ok, %Product{} = product} <- Products.update_product(product, product_params) do
      render(conn, :show, product: product)
    end
  end

  def delete(conn, %{"id" => id}) do
    product = Products.get_product!(id)

    with {:ok, %Product{}} <- Products.delete_product(product) do
      send_resp(conn, :no_content, "")
    end
  end
end
