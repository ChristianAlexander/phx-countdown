defmodule CountdownWeb.TimerLive.Show do
  use CountdownWeb, :live_view

  alias Countdown.Timers

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    timer = Timers.get_timer!(id)
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:timer, timer)}
  end

  defp page_title(:show), do: "Show Timer"
  defp page_title(:edit), do: "Edit Timer"
end
