defmodule SalesloftWeb.StatsController do
  use SalesloftWeb, :controller

  alias Salesloft.Data
  alias Salesloft.Data.Stats

  def index(conn, _params) do
    stats = Data.list_stats()
    render(conn, "index.html", stats: stats)
  end

  def new(conn, _params) do
    changeset = Data.change_stats(%Stats{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"stats" => stats_params}) do
    case Data.create_stats(stats_params) do
      {:ok, stats} ->
        conn
        |> put_flash(:info, "Stats created successfully.")
        |> redirect(to: Routes.stats_path(conn, :show, stats))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    stats = Data.get_stats!(id)
    render(conn, "show.html", stats: stats)
  end

  def edit(conn, %{"id" => id}) do
    stats = Data.get_stats!(id)
    changeset = Data.change_stats(stats)
    render(conn, "edit.html", stats: stats, changeset: changeset)
  end

  def update(conn, %{"id" => id, "stats" => stats_params}) do
    stats = Data.get_stats!(id)

    case Data.update_stats(stats, stats_params) do
      {:ok, stats} ->
        conn
        |> put_flash(:info, "Stats updated successfully.")
        |> redirect(to: Routes.stats_path(conn, :show, stats))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", stats: stats, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    stats = Data.get_stats!(id)
    {:ok, _stats} = Data.delete_stats(stats)

    conn
    |> put_flash(:info, "Stats deleted successfully.")
    |> redirect(to: Routes.stats_path(conn, :index))
  end
end
