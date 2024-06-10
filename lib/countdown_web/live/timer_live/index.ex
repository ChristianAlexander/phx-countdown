defmodule CountdownWeb.TimerLive.Index do
  use CountdownWeb, :live_view

  alias Countdown.Timers
  alias Countdown.Timers.Timer

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :timers, Timers.list_timers())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Timer")
    |> assign(:timer, Timers.get_timer!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Timer")
    |> assign(:timer, %Timer{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Timers")
    |> assign(:timer, nil)
  end

  @impl true
  def handle_info({CountdownWeb.TimerLive.FormComponent, {:saved, timer}}, socket) do
    {:noreply, stream_insert(socket, :timers, timer)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    timer = Timers.get_timer!(id)
    {:ok, _} = Timers.delete_timer(timer)

    {:noreply, stream_delete(socket, :timers, timer)}
  end
end
