defmodule TsundokuBuster.Repo do
  use Ecto.Repo,
    otp_app: :tsundoku_buster,
    adapter: Ecto.Adapters.MyXQL
end
