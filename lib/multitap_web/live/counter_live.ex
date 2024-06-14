defmodule MultitapWeb.CounterLive do
  use MultitapWeb, :live_view

  alias Multitap.Counter

  def mount(params, _session, socket) do
    name = "counter_#{params["counter_number"]}"

    if Counter.whereis(name) == :ok do
      if connected?(socket), do: MultitapWeb.Endpoint.subscribe(name)

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
    value = Counter.get(socket.assigns.name)
    MultitapWeb.Endpoint.broadcast(socket.assigns.name, "update", value)

    {:noreply, socket}
  end

  def handle_event("dec", _params, socket) do
    Counter.update(socket.assigns.name, -1)
    value = Counter.get(socket.assigns.name)
    MultitapWeb.Endpoint.broadcast(socket.assigns.name, "update", value)

    {:noreply, socket}
  end

  def handle_info(%{event: "update", payload: value}, socket) do
    {:noreply, update(socket, :value, fn _ -> value end)}
  end
end
