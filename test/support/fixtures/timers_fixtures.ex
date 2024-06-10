defmodule Countdown.TimersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Countdown.Timers` context.
  """

  @doc """
  Generate a timer.
  """
  def timer_fixture(attrs \\ %{}) do
    {:ok, timer} =
      attrs
      |> Enum.into(%{
        end_at: ~U[2024-06-08 21:11:00Z],
        name: "some name"
      })
      |> Countdown.Timers.create_timer()

    timer
  end
end
