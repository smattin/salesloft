defmodule Salesloft.DataTest do
  use Salesloft.DataCase

  alias Salesloft.Data

  describe "people" do
    alias Salesloft.Data.People

    @valid_attrs %{display_name: "some display_name", email_address: "some email_address", title: "some title"}
    @update_attrs %{display_name: "some updated display_name", email_address: "some updated email_address", title: "some updated title"}
    @invalid_attrs %{display_name: nil, email_address: nil, title: nil}

    def people_fixture(attrs \\ %{}) do
      {:ok, people} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Data.create_people()

      people
    end

    test "list_people/0 returns all people" do
      people = people_fixture()
      assert Data.list_people() == [people]
    end

    test "get_people!/1 returns the people with given id" do
      people = people_fixture()
      assert Data.get_people!(people.id) == people
    end

    test "create_people/1 with valid data creates a people" do
      assert {:ok, %People{} = people} = Data.create_people(@valid_attrs)
      assert people.display_name == "some display_name"
      assert people.email_address == "some email_address"
      assert people.title == "some title"
    end

    test "create_people/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Data.create_people(@invalid_attrs)
    end

    test "update_people/2 with valid data updates the people" do
      people = people_fixture()
      assert {:ok, %People{} = people} = Data.update_people(people, @update_attrs)
      assert people.display_name == "some updated display_name"
      assert people.email_address == "some updated email_address"
      assert people.title == "some updated title"
    end

    test "update_people/2 with invalid data returns error changeset" do
      people = people_fixture()
      assert {:error, %Ecto.Changeset{}} = Data.update_people(people, @invalid_attrs)
      assert people == Data.get_people!(people.id)
    end

    test "delete_people/1 deletes the people" do
      people = people_fixture()
      assert {:ok, %People{}} = Data.delete_people(people)
      assert_raise Ecto.NoResultsError, fn -> Data.get_people!(people.id) end
    end

    test "change_people/1 returns a people changeset" do
      people = people_fixture()
      assert %Ecto.Changeset{} = Data.change_people(people)
    end
  end
end
