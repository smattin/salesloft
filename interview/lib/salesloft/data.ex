defmodule Salesloft.Data do
  @moduledoc """
  The Data context.
  """
  require Logger
  import Ecto.Query, warn: false
  alias Salesloft.Repo

  alias Salesloft.Data.People

  @doc """
  Returns the list of people.

  ## Examples

      iex> list_people()
      [%People{}, ...]

  """
  def list_people do
    Repo.all(People)
  end

  @doc """
  Gets a single people.

  Raises `Ecto.NoResultsError` if the People does not exist.

  ## Examples

      iex> get_people!(123)
      %People{}

      iex> get_people!(456)
      ** (Ecto.NoResultsError)

  """
  def get_people!(id), do: Repo.get!(People, id)

  @doc """
  Creates a people.

  ## Examples

      iex> create_people(%{field: value})
      {:ok, %People{}}

      iex> create_people(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_people(attrs \\ %{}) do
    %People{}
    |> People.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a people.

  ## Examples

      iex> update_people(people, %{field: new_value})
      {:ok, %People{}}

      iex> update_people(people, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_people(%People{} = people, attrs) do
    people
    |> People.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a people.

  ## Examples

      iex> delete_people(people)
      {:ok, %People{}}

      iex> delete_people(people)
      {:error, %Ecto.Changeset{}}

  """
  def delete_people(%People{} = people) do
    Repo.delete(people)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking people changes.

  ## Examples

      iex> change_people(people)
      %Ecto.Changeset{data: %People{}}

  """
  def change_people(%People{} = people, attrs \\ %{}) do
    People.changeset(people, attrs)
  end

  @doc """
  Returns the stats on the email addresses of people.

  ## Examples

      iex> email_address_stats()
      [%People{}, ...]

 
  def email_address_stats() do
    Repo.all(People) |> 
  end
  """

  alias Salesloft.Data.Stats

  @doc """
  Returns the stats on the email addresses of people.

  ## Examples

      iex> list_stats()
      [%Stats{}, ...]

  """
  def list_stats do
    addresses = Enum.map(list_people(),fn(person) -> person.email_address end)
    Logger.debug(["addresses": addresses])
    all = Enum.join(addresses,"")
    Logger.debug(["all": all])
    all |> String.graphemes() |> Enum.reduce(%{}, fn char, acc -> Map.put(acc, char, (acc[char] || 0) + 1) end)
        |> Map.to_list |> Enum.each(fn(k,v) -> %Stats{char: k, count: v} end)
  end

  @doc """
  Gets a single stats.

  Raises `Ecto.NoResultsError` if the Stats does not exist.

  ## Examples

      iex> get_stats!(123)
      %Stats{}

      iex> get_stats!(456)
      ** (Ecto.NoResultsError)

  """
  def get_stats!(id), do: Repo.get!(Stats, id)

  @doc """
  Creates a stats.

  ## Examples

      iex> create_stats(%{field: value})
      {:ok, %Stats{}}

      iex> create_stats(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_stats(attrs \\ %{}) do
    %Stats{}
    |> Stats.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a stats.

  ## Examples

      iex> update_stats(stats, %{field: new_value})
      {:ok, %Stats{}}

      iex> update_stats(stats, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_stats(%Stats{} = stats, attrs) do
    stats
    |> Stats.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a stats.

  ## Examples

      iex> delete_stats(stats)
      {:ok, %Stats{}}

      iex> delete_stats(stats)
      {:error, %Ecto.Changeset{}}

  """
  def delete_stats(%Stats{} = stats) do
    Repo.delete(stats)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking stats changes.

  ## Examples

      iex> change_stats(stats)
      %Ecto.Changeset{data: %Stats{}}

  """
  def change_stats(%Stats{} = stats, attrs \\ %{}) do
    Stats.changeset(stats, attrs)
  end
end
