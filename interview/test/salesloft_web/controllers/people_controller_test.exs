defmodule SalesloftWeb.PeopleControllerTest do
  use SalesloftWeb.ConnCase

  alias Salesloft.Data
  alias Salesloft.Data.People

  @create_attrs %{
    display_name: "some display_name",
    email_address: "some email_address",
    title: "some title"
  }
  @update_attrs %{
    display_name: "some updated display_name",
    email_address: "some updated email_address",
    title: "some updated title"
  }
  @invalid_attrs %{display_name: nil, email_address: nil, title: nil}

  def fixture(:people) do
    {:ok, people} = Data.create_people(@create_attrs)
    people
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all people", %{conn: conn} do
      conn = get(conn, Routes.people_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create people" do
    test "renders people when data is valid", %{conn: conn} do
      conn = post(conn, Routes.people_path(conn, :create), people: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.people_path(conn, :show, id))

      assert %{
               "id" => id,
               "display_name" => "some display_name",
               "email_address" => "some email_address",
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.people_path(conn, :create), people: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update people" do
    setup [:create_people]

    test "renders people when data is valid", %{conn: conn, people: %People{id: id} = people} do
      conn = put(conn, Routes.people_path(conn, :update, people), people: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.people_path(conn, :show, id))

      assert %{
               "id" => id,
               "display_name" => "some updated display_name",
               "email_address" => "some updated email_address",
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, people: people} do
      conn = put(conn, Routes.people_path(conn, :update, people), people: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete people" do
    setup [:create_people]

    test "deletes chosen people", %{conn: conn, people: people} do
      conn = delete(conn, Routes.people_path(conn, :delete, people))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.people_path(conn, :show, people))
      end
    end
  end

  defp create_people(_) do
    people = fixture(:people)
    %{people: people}
  end
end
