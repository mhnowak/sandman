defmodule Morpheus.Repo do
  use Ecto.Repo,
    otp_app: :morpheus,
    adapter: Ecto.Adapters.Postgres
end
