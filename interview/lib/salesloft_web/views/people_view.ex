defmodule SalesloftWeb.PeopleView do
  use SalesloftWeb, :view
  alias SalesloftWeb.PeopleView

  def render("index.json", %{people: people}) do
    %{data: render_many(people, PeopleView, "people.json")}
  end

  def render("show.json", %{people: people}) do
    %{data: render_one(people, PeopleView, "people.json")}
  end

  def render("people.json", %{people: people}) do
    %{id: people.id,
      title: people.title,
      display_name: people.display_name,
      email_address: people.email_address}
  end
end
