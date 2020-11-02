defmodule TsundokuBuster.Usecase.User do
  alias TsundokuBuster.Database.User, as: UserRepo
  alias TsundokuBuster.Schema.User

  @spec get_authorize_url() :: {:ok, String.t()} | {:error, atom()}
  def get_authorize_url() do
      case ExTwitter.request_token() do
        {:ok, token} -> token
                        |> Map.get(:oauth_token)
                        |> ExTwitter.authorize_url()
        {:error, error} -> error
      end
  end

  @spec create_user_from_twitter(String.t(), String.t()) :: {:ok, %User{}} | {:error, atom()}
  def create_user_from_twitter(oauth_verifier, oauth_token) do
    case ExTwitter.access_token(oauth_verifier, oauth_token) do
      {:ok, creds} ->
          case ExTwitter.user(creds.user_id) do
            {:ok, twitter_user} -> 
                    case UserRepo.create_user(
                                  %{
                                    name: twitter_user.name,
                                    twitter_id: twitter_user.screen_name,
                                    oauth_token: creds.oauth_token,
                                    oauth_token_secret: creds.oauth_token_secret,
                                    created_at: Timex.now,
                                    updated_at: Timex.now
                                  }
                                )
                    do
                      {:ok, user} -> {:ok, user}
                      _           -> {:error, :cannot_store_user}
                    end
            error -> error
          end
      error -> error
    end
  end

  @spec get_user(String.t()) :: {:ok, %User{}} | {:error, atom()}
  def get_user(id) do
    UserRepo.get_user(id)
  end

  @spec update_user(String.t()) :: {:ok, %User{}} | {:error, atom()}
  def update_user(id) do
    case UserRepo.get_user(id) do
      {:ok, user} ->
          case ExTwitter.user(user.twitter_id) do
            {:ok, twitter_user} ->
                    case UserRepo.update_user(
                                  user,
                                  %{
                                    name: twitter_user.name,
                                    twitter_id: twitter_user.screen_name,
                                    updated_at: Timex.now
                                  }
                                )
                    do
                      {:ok, user} -> {:ok, user}
                      _           -> {:error, :cannot_store_user}
                    end
            error -> error
          end
      error -> error
    end
  end


  @spec delete_user(String.t()) :: {:ok, :no_content} | {:error, atom()}
  def delete_user(id) do
    case UserRepo.get_user(id) do
      {:ok, user} ->
        case UserRepo.delete_user(user) do
          {:ok, _} -> {:ok, :no_content}
          {:error, _} -> {:error, :cannot_delete_user}
        end
      error -> error
    end
  end
end
