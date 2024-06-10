defmodule MultitapWeb.CounterTest do
  use MultitapWeb.ConnCase, async: true

  import PhoenixTest
  import Multitap.AccountsFixtures

  test "create my own counter", %{conn: conn} do
    user = user_fixture()

    conn
    |> login(user)
    |> visit(~p"/")
    |> click_button("new counter")
    |> assert_has("h2", text: "value: 100")
    |> click_button("+")
    |> click_button("+")
    |> assert_has("h2", text: "value: 102")
    |> click_button("-")
    |> assert_has("h2", text: "value: 101")

    # build_conn()
    # |> visit(~p"/")
    # |> click_button("new counter")
    # |> assert_has("h2", text: "value: 100")
  end

  test "create another counter", %{conn: conn} do
    user = user_fixture()

    conn =
      conn
      |> login(user)
      |> visit(~p"/")
      |> click_button("new counter")
      |> click_button("+")
      |> assert_has("h2", text: "value: 101")

    build_conn()
    |> visit(~p"/")
    |> fill_in("counter number", with: "#{user.id}")
    |> click_button("enter")
    |> assert_has("h2", text: "value: 101")
    |> click_button("+")
    |> assert_has("h2", text: "value: 102")

    conn
    |> assert_has("h2", text: "value: 102")
  end
end
