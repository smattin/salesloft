defmodule SalesloftWeb.PeopleController do
  use SalesloftWeb, :controller

  alias Salesloft.Data
  alias Salesloft.Data.People

  action_fallback SalesloftWeb.FallbackController

  def index(conn, _params) do
    people = Data.list_people()
    render(conn, "index.json", people: people)
  end

  def create(conn, %{"people" => people_params}) do
    with {:ok, %People{} = people} <- Data.create_people(people_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.people_path(conn, :show, people))
      |> render("show.json", people: people)
    end
  end

  def show(conn, %{"id" => id}) do
    people = Data.get_people!(id)
    render(conn, "show.json", people: people)
  end

  def update(conn, %{"id" => id, "people" => people_params}) do
    people = Data.get_people!(id)

    with {:ok, %People{} = people} <- Data.update_people(people, people_params) do
      render(conn, "show.json", people: people)
    end
  end

  def delete(conn, %{"id" => id}) do
    people = Data.get_people!(id)

    with {:ok, %People{}} <- Data.delete_people(people) do
      send_resp(conn, :no_content, "")
    end
  end
end
