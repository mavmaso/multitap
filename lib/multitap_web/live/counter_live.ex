defmodule MultitapWeb.CounterLive do
  use MultitapWeb, :live_view

  alias Multitap.Counter

  def mount(params, _session, socket) do
    name = "counter_#{params["counter_number"]}"

    if Counter.whereis(name) == :ok do
      socket =
        socket
        |> assign(:name, name)
        |> assign(:value, Multitap.Counter.get(name))

      {:ok, socket}
    else
      {:ok, redirect(socket, to: ~p"/")}
    end
  end

  def render(assigns) do
    ~H"""
    <h2>value: <%= @value %></h2>
    <button phx-click="inc">+</button>
    <button phx-click="dec">-</button>
    """
  end

  def handle_event("inc", _params, socket) do
    Counter.update(socket.assigns.name, 1)
    {:noreply, update(socket, :value, fn _ -> Counter.get(socket.assigns.name) end)}
  end

  def handle_event("dec", _params, socket) do
    Counter.update(socket.assigns.name, -1)
    {:noreply, update(socket, :value, fn _ -> Counter.get(socket.assigns.name) end)}
  end
end
