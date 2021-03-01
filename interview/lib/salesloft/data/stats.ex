defmodule Salesloft.Data.Stats do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stats" do
    field :char, :string
    field :count, :integer

    timestamps()
  end

  @doc false
  def changeset(stats, attrs) do
    stats
    |> cast(attrs, [:char, :count])
    |> validate_required([:char, :count])
  end
end
