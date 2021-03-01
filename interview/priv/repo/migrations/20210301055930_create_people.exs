defmodule Salesloft.Repo.Migrations.CreatePeople do
  use Ecto.Migration

  def change do
    create table(:people) do
      add :title, :string
      add :display_name, :string
      add :email_address, :string

      timestamps()
    end

  end
end
