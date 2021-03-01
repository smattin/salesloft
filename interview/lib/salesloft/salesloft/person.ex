defmodule Salesloft.Salesloft.Person do
  use Ecto.Schema
  import Ecto.Changeset

  schema "person" do
    field :email_address, :string
    field :full_name, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(person, attrs) do
    person
    |> cast(attrs, [:full_name, :title, :email_address])
    |> validate_required([:full_name, :title, :email_address])
  end
end
