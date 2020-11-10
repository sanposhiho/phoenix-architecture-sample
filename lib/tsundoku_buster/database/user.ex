defmodule TsundokuBuster.Database.User do
  @moduledoc """
  manage users in Database
  """
  @behaviour TsundokuBuster.Repository.UserBehaviour

  import Ecto.Query, warn: false
  alias TsundokuBuster.Repo

  alias TsundokuBuster.Schema.User

  @type attrs :: %{
          optional(:name) => String.t(),
          optional(:twitter_id) => String.t(),
          optional(:oauth_token) => String.t(),
          optional(:oauth_token_secret) => String.t(),
          optional(:created_at) => DateTime.t(),
          optional(:updated_at) => DateTime.t()
        }

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  @impl TsundokuBuster.Repository.UserBehaviour
  @spec list_users() :: [%User{}]
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  ## Examples

      iex> get_user(123)
      {:ok, %User{}}

      iex> get_user(456)
      {:error, :not_found}

  """
  @impl TsundokuBuster.Repository.UserBehaviour
  @spec get_user(id :: String.t()) :: {:ok, %User{}} | {:error, atom()}
  def get_user(id) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @impl TsundokuBuster.Repository.UserBehaviour
  @spec create_user(attrs :: TsundokuBuster.Database.User.attrs()) ::
          {:ok, %User{}} | {:error, %Ecto.Changeset{}}
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @impl TsundokuBuster.Repository.UserBehaviour
  @spec update_user(user :: %User{}, attrs :: TsundokuBuster.Database.User.attrs()) ::
          {:ok, %User{}} | {:error, %Ecto.Changeset{}}
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  @impl TsundokuBuster.Repository.UserBehaviour
  @spec delete_user(user :: %User{}) :: {:ok, %User{}} | {:error, %Ecto.Changeset{}}
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  @impl TsundokuBuster.Repository.UserBehaviour
  @spec change_user(user :: %User{}, attrs :: TsundokuBuster.Database.User.attrs()) ::
          %Ecto.Changeset{}
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
