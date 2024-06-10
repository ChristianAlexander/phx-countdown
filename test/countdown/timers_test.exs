defmodule Countdown.TimersTest do
  use Countdown.DataCase

  alias Countdown.Timers

  describe "timers" do
    alias Countdown.Timers.Timer

    import Countdown.TimersFixtures

    @invalid_attrs %{name: nil, end_at: nil}

    test "list_timers/0 returns all timers" do
      timer = timer_fixture()
      assert Timers.list_timers() == [timer]
    end

    test "get_timer!/1 returns the timer with given id" do
      timer = timer_fixture()
      assert Timers.get_timer!(timer.id) == timer
    end

    test "create_timer/1 with valid data creates a timer" do
      valid_attrs = %{name: "some name", end_at: ~U[2024-06-08 21:11:00Z]}

      assert {:ok, %Timer{} = timer} = Timers.create_timer(valid_attrs)
      assert timer.name == "some name"
      assert timer.end_at == ~U[2024-06-08 21:11:00Z]
    end

    test "create_timer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Timers.create_timer(@invalid_attrs)
    end

    test "update_timer/2 with valid data updates the timer" do
      timer = timer_fixture()
      update_attrs = %{name: "some updated name", end_at: ~U[2024-06-09 21:11:00Z]}

      assert {:ok, %Timer{} = timer} = Timers.update_timer(timer, update_attrs)
      assert timer.name == "some updated name"
      assert timer.end_at == ~U[2024-06-09 21:11:00Z]
    end

    test "update_timer/2 with invalid data returns error changeset" do
      timer = timer_fixture()
      assert {:error, %Ecto.Changeset{}} = Timers.update_timer(timer, @invalid_attrs)
      assert timer == Timers.get_timer!(timer.id)
    end

    test "delete_timer/1 deletes the timer" do
      timer = timer_fixture()
      assert {:ok, %Timer{}} = Timers.delete_timer(timer)
      assert_raise Ecto.NoResultsError, fn -> Timers.get_timer!(timer.id) end
    end

    test "change_timer/1 returns a timer changeset" do
      timer = timer_fixture()
      assert %Ecto.Changeset{} = Timers.change_timer(timer)
    end
  end
end
