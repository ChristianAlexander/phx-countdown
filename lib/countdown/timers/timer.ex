defmodule Countdown.Timers.Timer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "timers" do
    field :name, :string
    field :end_at, :utc_datetime

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(timer, attrs) do
    timer
    |> cast(attrs, [:name, :end_at])
    |> validate_required([:name, :end_at])
  end

  def time_until(timer) do
    case DateTime.diff(timer.end_at, DateTime.utc_now(), :second) do
      duration when duration <= 0 ->
        "00:00:00"

      duration ->
        hours = div(duration, 3600)
        minutes = div(rem(duration, 3600), 60)
        seconds = rem(rem(duration, 3600), 60)

        "#{String.pad_leading(Integer.to_string(hours), 2, "0")}:#{String.pad_leading(Integer.to_string(minutes), 2, "0")}:#{String.pad_leading(Integer.to_string(seconds), 2, "0")}"
    end
  end
end
