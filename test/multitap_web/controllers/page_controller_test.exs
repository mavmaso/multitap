defmodule MultitapWeb.PageControllerTest do
  use MultitapWeb.ConnCase, async: true

  import PhoenixTest

  test "GET /", %{conn: conn} do
    conn
    |> visit(~p"/")
    |> assert_has("p", "Peace of mind from prototype to production")
  end
end
