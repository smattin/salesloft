defmodule SalesloftWeb.PageLive do
  use SalesloftWeb, :live_view
  require Logger
  alias Salesloft.Data
  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: "", results:
     [%{
      id: 249340741,
      full_name: "Steven Pease",
      email_address: "sakatius@gmail.com",
      title: "Software Engineer",
     },
     %{
      id: 251436152,
      full_name: "Possibly Duplicate",
      email_address: "sakatius@gmail.com",
      "title": "My Job",
     },
    ]
     )}
  end

  @impl true
  def handle_event("stats", %{"q" => query}, socket) do
    {:ok, assign(socket, query: "", stats: Data.list_stats())}
  end

  @impl true
  def handle_event("refresh", %{"q" => query}, socket) do
    case refresh(query) do
      {stats} -> {}

      _ ->
        {:noreply,
         socket
         |> put_flash(:error, "No email stats found")
         |> assign(stats: %{}, query: query)}
    end
  end

  defp refresh(query) do
    if not SalesloftWeb.Endpoint.config(:code_reloader) do
      raise "action disabled when not in development"
    end

    for {app, desc, vsn} <- Application.started_applications(),
        app = to_string(app),
        String.starts_with?(app, query) and not List.starts_with?(desc, ~c"ERTS"),
        into: %{},
        do: {app, vsn}
  end
end
