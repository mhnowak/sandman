defmodule Morpheus.Products do
  @moduledoc """
  The Products context.
  """

  import Ecto.Query, warn: false
  alias Morpheus.Repo
  alias Morpheus.Products
  alias Morpheus.Products.Product

  @doc """
  Returns the list of products.

  ## Examples

      iex> list_products()
      [%Product{}, ...]

  """
  def list_products do
    Repo.all(Product)
  end

  @doc """
  Gets a single product.
  """
  def get_product(id) do
    case Repo.get(Product, id) do
      nil ->
        {:error, :not_found}

      %Product{is_deleted: true} = _product ->
        {:error, :deleted}

      product ->
        {:ok, product}
    end
  end

  @doc """
  Creates a product.

  ## Examples

      iex> create_product(%{field: value})
      {:ok, %Product{}}

      iex> create_product(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a product.

  ## Examples

      iex> update_product(product, %{field: new_value})
      {:ok, %Product{}}

      iex> update_product(product, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product(product_id, attrs) do
    case Products.get_product(product_id) do
      {:error, _} = error ->
        error

      {:ok, product} ->
        product
        |> Product.changeset(attrs)
        |> Repo.update()
    end
  end

  @doc """
  Deletes a product.

  ## Examples

      iex> delete_product(product)
      {:ok, %Product{}}

      iex> delete_product(product)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product(%Product{} = product) do
    product |> Product.changeset(%{is_deleted: true}) |> Repo.update()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product changes.

  ## Examples

      iex> change_product(product)
      %Ecto.Changeset{data: %Product{}}

  """
  def change_product(%Product{} = product, attrs \\ %{}) do
    Product.changeset(product, attrs)
  end
end
