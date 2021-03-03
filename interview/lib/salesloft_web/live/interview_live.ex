defmodule SalesloftWeb.InterviewLive do
    require Logger
    use SalesloftWeb, :live_view
    alias Salesloft.Data

    def mount(_params,_session,socket) do # ignore params, session - don't need for this app
        stats = %{} # Data.list_stats()
        Logger.debug([stats: stats])
        people = Data.list_people()
        Logger.debug(["people": people])
        socket = assign(socket, people: people, stats: stats)
        IO.inspect(socket)
        {:ok, socket}
    end

    def render(assigns) do
      ~L"""
      <section class="phx-hero">
          <h1><%= gettext "%{name} Interview People Demo", name: "Salesloft" %></h1>
          <p>Level 1</p>
          <table>
            <thead>
              <tr>
                <%= for col <- ["Job","Name","Email"] do %>
                  <th style="color:Gray; padding-left:1em"><%= col %></th>
                <% end %>
              </tr>
            </thead>

            <datalist id="people">
              <%= for p <- @people do %>
                <tr>
                  <td><%= p.title %></td>
                  <td><%= p.display_name %></td>
                  <td><%= p.email_address %></td>
                </tr>
              <% end %>
            </datalist>

          </table>
      </section>
      <section class="phx-hero">
        <p>Level 2</p>
          <form phx-change="stats" phx-submit="refresh">
          <button type="submit" phx-disable-with="Calculating...">Email address stats</button>
      
            <table>
            <thead>
              <tr>
                <%= for col <- ["Character","Count"] do %>
                  <th style="color:Gray; padding-left:1em"><%= col %></th>
                <% end %>
              </tr>
            </thead>
            <datalist id="stats">
              <%= for stat <- @stats do %>
                <tr>
                  <td><%= stat.char %></td>
                  <td><%= stat.count %></td>
                </tr>
              <% end %>
            </datalist>
            </table>
          </form>
      </section
      """
    end
end
