defmodule Countdown.Repo.Migrations.CreateTimers do
  use Ecto.Migration

  def change do
    create table(:timers) do
      add :name, :text
      add :end_at, :utc_datetime

      timestamps(type: :utc_datetime)
    end
  end
end
