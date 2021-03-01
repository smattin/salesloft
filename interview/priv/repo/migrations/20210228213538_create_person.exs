defmodule Salesloft.Repo.Migrations.CreatePerson do
  use Ecto.Migration

  def change do
    create table(:person) do
      add :full_name, :string
      add :title, :string
      add :email_address, :string

      timestamps()
    end

  end
end
