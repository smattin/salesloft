defmodule Salesloft.Repo.Migrations.CreateStats do
  use Ecto.Migration

  def change do
    create table(:stats) do
      add :char, :string
      add :count, :integer

      timestamps()
    end

  end
end
