defmodule Countdown.Repo do
  use Ecto.Repo,
    otp_app: :countdown,
    adapter: Ecto.Adapters.SQLite3
end
