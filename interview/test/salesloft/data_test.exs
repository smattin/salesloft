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

  describe "stats" do
    alias Salesloft.Data.Stats

    @valid_attrs %{char: "some char", count: 42}
    @update_attrs %{char: "some updated char", count: 43}
    @invalid_attrs %{char: nil, count: nil}

    def stats_fixture(attrs \\ %{}) do
      {:ok, stats} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Data.create_stats()

      stats
    end

    test "list_stats/0 returns all stats" do
      stats = stats_fixture()
      assert Data.list_stats() == [stats]
    end

    test "get_stats!/1 returns the stats with given id" do
      stats = stats_fixture()
      assert Data.get_stats!(stats.id) == stats
    end

    test "create_stats/1 with valid data creates a stats" do
      assert {:ok, %Stats{} = stats} = Data.create_stats(@valid_attrs)
      assert stats.char == "some char"
      assert stats.count == 42
    end

    test "create_stats/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Data.create_stats(@invalid_attrs)
    end

    test "update_stats/2 with valid data updates the stats" do
      stats = stats_fixture()
      assert {:ok, %Stats{} = stats} = Data.update_stats(stats, @update_attrs)
      assert stats.char == "some updated char"
      assert stats.count == 43
    end

    test "update_stats/2 with invalid data returns error changeset" do
      stats = stats_fixture()
      assert {:error, %Ecto.Changeset{}} = Data.update_stats(stats, @invalid_attrs)
      assert stats == Data.get_stats!(stats.id)
    end

    test "delete_stats/1 deletes the stats" do
      stats = stats_fixture()
      assert {:ok, %Stats{}} = Data.delete_stats(stats)
      assert_raise Ecto.NoResultsError, fn -> Data.get_stats!(stats.id) end
    end

    test "change_stats/1 returns a stats changeset" do
      stats = stats_fixture()
      assert %Ecto.Changeset{} = Data.change_stats(stats)
    end
  end
end
