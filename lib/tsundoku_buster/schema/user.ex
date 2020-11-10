defmodule TsundokuBuster.Schema.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :name, :string
    field :twitter_id, :string
    field :oauth_token, :string
    field :oauth_token_secret, :string
    field :created_at, :utc_datetime
    field :updated_at, :utc_datetime
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :name,
      :twitter_id,
      :oauth_token,
      :oauth_token_secret,
      :created_at,
      :updated_at
    ])
    |> validate_required([
      :name,
      :twitter_id,
      :oauth_token,
      :oauth_token_secret,
      :created_at,
      :updated_at
    ])
  end
end
