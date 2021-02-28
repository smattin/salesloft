defmodule Salesloft.Repo do
  use Ecto.Repo,
    otp_app: :salesloft,
    adapter: Ecto.Adapters.Postgres
end
