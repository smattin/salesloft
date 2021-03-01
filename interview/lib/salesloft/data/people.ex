defmodule Salesloft.Data.People do
  use Ecto.Schema
  import Ecto.Changeset

  schema "people" do
    field :display_name, :string
    field :email_address, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(people, attrs) do
    people
    |> cast(attrs, [:title, :display_name, :email_address])
    |> validate_required([:title, :display_name, :email_address])
  end
end
