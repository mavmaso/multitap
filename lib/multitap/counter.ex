defmodule Multitap.Counter do
  use GenServer

  def start_link(name) do
    GenServer.start_link(__MODULE__, nil, name: global_name(name))
  end

  def get(name), do: GenServer.call(global_name(name), :get)

  def update(name, value), do: GenServer.cast(global_name(name), {:update, value})

  def whereis(name) do
    if :global.whereis_name({__MODULE__, name}) == :undefined, do: :not_found, else: :ok
  end

  @impl true
  def init(_args) do
    {:ok, 100}
  end

  @impl true
  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_cast({:update, value}, state) do
    {:noreply, state + value}
  end

  defp global_name(name), do: {:global, {__MODULE__, name}}
end
