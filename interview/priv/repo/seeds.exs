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
alias Salesloft.Data.People

json_file = "#{__DIR__}/people.json"

with {:ok, body} <- File.read(json_file),
     {:ok, people} <- Jason.decode(body, keys: :atoms) do
    # insert to db
    Enum.each([ # TODO: #1 use people.data read directly from https://api.salesloft.com/v2/people.json
      %People{title: "Software Engineer", display_name: "Steven Pease", email_address: "sakatius@gmail.com"},
      %People{title: "My Job", display_name: "Possibly Duplicate", email_address: "sakatius@gmail.com"}
      ], fn(person) -> Repo.insert!(person) end)
else
  err ->
      IO.inspect(err)
end
