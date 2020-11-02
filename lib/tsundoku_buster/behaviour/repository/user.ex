defmodule TsundokuBuster.Repository.UserBehaviour do
  alias TsundokuBuster.Schema.User

  @callback list_users() :: [%User{}]
  @callback get_user(id :: String.t()) :: {:ok, %User{}} | {:error, atom()}
  @callback create_user(attrs :: TsundokuBuster.Database.User.attrs) :: {:ok, %User{}} | {:error, %Ecto.Changeset{}}
  @callback update_user(user :: %User{}, attrs :: TsundokuBuster.Database.User.attrs) :: {:ok, %User{}} | {:error, %Ecto.Changeset{}}
  @callback delete_user(user :: %User{}) :: {:ok, %User{}} | {:error, %Ecto.Changeset{}}
  @callback change_user(user :: %User{}, attrs :: TsundokuBuster.Database.User.attrs) :: %Ecto.Changeset{}
end
