# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Morpheus.Repo.insert!(%Morpheus.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Morpheus.Repo
alias Morpheus.Products.Product

# Repo.insert!(%Product{
#   title: "Canon camera",
#   description: "Very good camera.",
#   is_deleted: false,
#   image_url: "https://images.unsplash.com/photo-1495194757773-40c27034b638"
# })

# Repo.insert!(%Product{
#   title: "Vintage camera",
#   description: "Old but reliable.",
#   is_deleted: false,
#   image_url: "https://images.unsplash.com/photo-1597424877019-3533c54593b6"
# })

# Repo.insert!(%Product{
#   title: "Deleted camera",
#   description: "-",
#   is_deleted: true,
#   image_url: "https://images.unsplash.com/photo-1597424877019-3533c54593b6"
# })
