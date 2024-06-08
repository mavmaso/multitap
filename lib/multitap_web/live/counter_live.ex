defmodule MultitapWeb.CounterLive do
  use MultitapWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :value, 100)}
  end

  def render(assigns) do
    ~H"""
    <h2>value: <%= @value %></h2>
    <button phx-click="inc">+</button>
    <button phx-click="dec">-</button>
    """
  end

  def handle_event("inc", _params, socket) do
    {:noreply, update(socket, :value, &(&1 + 1))}
  end

  def handle_event("dec", _params, socket) do
    {:noreply, update(socket, :value, &(&1 - 1))}
  end
end
