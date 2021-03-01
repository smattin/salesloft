# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Salesloft.Repo.insert!(%Salesloft.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
#
alias Salesloft.Repo
alias Salesloft.Person

json_file = "#{__DIR__}/people.json"

with {:ok, body} <- File.read(json_file),
     {:ok, json} <- Jason.decode(body, keys: :atoms) do
  # insert to db
  Repo.insert! json
else
  err ->
      IO.inspect(err)
end
