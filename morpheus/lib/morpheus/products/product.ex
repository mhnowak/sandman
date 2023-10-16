defmodule Morpheus.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :description, :string
    field :title, :string
    field :is_deleted, :boolean, default: false
    field :image_url, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:title, :description, :is_deleted, :image_url])
    |> validate_required([:title, :description, :is_deleted, :image_url])
  end
end
