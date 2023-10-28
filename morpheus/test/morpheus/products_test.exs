defmodule Morpheus.ProductsTest do
  use Morpheus.DataCase

  alias Morpheus.Products

  describe "products" do
    alias Morpheus.Products.Product

    import Morpheus.ProductsFixtures

    @invalid_attrs %{
      description: nil,
      title: nil,
      is_deleted: nil,
      image_url: nil,
      creation_date: nil
    }

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Products.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Products.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      valid_attrs = %{
        description: "some description",
        title: "some title",
        image_url: "some image_url"
      }

      assert {:ok, %Product{} = product} = Products.create_product(valid_attrs)
      assert product.description == "some description"
      assert product.title == "some title"
      assert product.image_url == "some image_url"
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()

      update_attrs = %{
        description: "some updated description",
        title: "some updated title",
        image_url: "some updated image_url"
      }

      assert {:ok, %Product{} = product} = Products.update_product(product, update_attrs)
      assert product.description == "some updated description"
      assert product.title == "some updated title"
      assert product.image_url == "some updated image_url"
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_product(product, @invalid_attrs)
      assert product == Products.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Products.delete_product(product)

      prdt = Products.get_product!(product.id)
      assert prdt.is_deleted == true
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Products.change_product(product)
    end
  end
end
