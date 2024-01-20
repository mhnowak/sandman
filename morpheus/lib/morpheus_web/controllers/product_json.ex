defmodule MorpheusWeb.ProductJSON do
  alias Morpheus.Products.Product

  @doc """
  Renders a list of products.
  """
  def index(%{products: products}) do
    %{data: for(product <- products, do: data(product))}
  end

  @doc """
  Renders a single product.
  """
  def show(%{product: product}) do
    %{data: data(product)}
  end

  defp data(%Product{} = product) do
    %{
      id: product.id,
      title: product.title,
      description: product.description,
      image_url: product.image_url
    }
  end

  def item_deleted(%{product: product}) do
    %{
      error: "Item has been deleted"
    }
  end
end
