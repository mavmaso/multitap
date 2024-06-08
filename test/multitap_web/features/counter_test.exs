defmodule MultitapWeb.CounterTest do
  use MultitapWeb.ConnCase, async: true

  import PhoenixTest

  test "create my own counter", %{conn: conn} do
    conn
    |> visit(~p"/")
    |> click_button("new counter")
    |> assert_has("h2", text: "value: 100")
    |> click_button("+")
    |> click_button("+")
    |> assert_has("h2", text: "value: 102")
    |> click_button("-")
    |> assert_has("h2", text: "value: 101")

    build_conn()
    |> visit(~p"/")
    |> click_button("new counter")
    |> assert_has("h2", text: "value: 100")
  end
end