defmodule SalesloftWeb.PageLiveTest do
  use SalesloftWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Salesloft Interview People Demo"
    assert render(page_live) =~ "Salesloft Interview People Demo"
  end
end
