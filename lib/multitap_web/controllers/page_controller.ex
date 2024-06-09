defmodule MultitapWeb.PageController do
  alias Multitap.Counter
  use MultitapWeb, :controller

  def home(conn, _params) do
    render(conn, :home, layout: false)
  end

  def create(conn, _params) do
    user = conn.assigns.current_user
    name = "counter_#{user.id}"
    Counter.start_link(name)

    conn
    |> redirect(to: ~p"/counter?counter_number=#{user.id}")
  end
end
