defmodule Morpheus.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :title, :string
      add :description, :text
      add :is_deleted, :boolean, default: false, null: false
      add :image_url, :text

      timestamps(type: :utc_datetime)
    end
  end
end
