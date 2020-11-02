defmodule TsundokuBuster.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :twitter_id, :string
      add :oauth_token, :string
      add :oauth_token_secret, :string
      add :created_at, :naive_datetime
      add :updated_at, :naive_datetime
    end

  end
end
