defmodule Morpheus.ProductsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Morpheus.Products` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        creation_date: ~D[2023-10-14],
        description: "some description",
        image_url: "some image_url",
        is_deleted: true,
        title: "some title"
      })
      |> Morpheus.Products.create_product()

    product
  end
end
