defmodule TsundokuBuster.Usecase.UserTest do
  alias TsundokuBuster.Usecase.User, as: UserUsecase
  alias TsundokuBuster.Schema.User
  alias TsundokuBuster.Repository.UserMock
  use ExUnit.Case, async: true
  import Mox

  setup :verify_on_exit!

  describe "get_authorize_url/0" do
    test "APIへのリクエストが全て成功した場合authorize_urlが返される" do
      ExTwitterMock
      |> expect(:request_token, fn ->
        {:ok, %ExTwitter.Model.RequestToken{oauth_token: "token"}}
      end)
      |> expect(:authorize_url, fn "token" -> {:ok, "url"} end)

      assert UserUsecase.get_authorize_url() == {:ok, "url"}
    end

    test "APIへのリクエストに何かしらのエラーが起きた際にはエラーがかえる" do
      ExTwitterMock
      |> expect(:request_token, fn -> {:error, :reason} end)

      assert UserUsecase.get_authorize_url() == {:error, :reason}
    end
  end

  describe "create_user_from_twitter/2" do
    test "APIへのリクエスト、DBへの保存が全て成功した場合、作成されたユーザーがかえる" do
      ExTwitterMock
      |> expect(:access_token, fn "oauth_verifier", "oauth_token" ->
        {
          :ok,
          %ExTwitter.Model.AccessToken{
            user_id: "user_id",
            oauth_token: "oauth_token",
            oauth_token_secret: "oauth_token_secret"
          }
        }
      end)
      |> expect(:user, fn "user_id" ->
        {
          :ok,
          %ExTwitter.Model.User{
            name: "name",
            screen_name: "screen_name"
          }
        }
      end)

      UserMock
      |> expect(:create_user, fn %{
                                   name: "name",
                                   twitter_id: "screen_name",
                                   oauth_token: "oauth_token",
                                   oauth_token_secret: "oauth_token_secret"
                                 } ->
        {:ok,
         %User{
           name: "name",
           twitter_id: "screen_name",
           oauth_token: "oauth_token",
           oauth_token_secret: "oauth_token_secret"
         }}
      end)

      assert UserUsecase.create_user_from_twitter("oauth_verifier", "oauth_token") ==
               {:ok,
                %User{
                  name: "name",
                  twitter_id: "screen_name",
                  oauth_token: "oauth_token",
                  oauth_token_secret: "oauth_token_secret"
                }}
    end

    test "access_tokenのAPIへのリクエストが失敗した場合、errorがかえる" do
      ExTwitterMock
      |> expect(:access_token, fn "oauth_verifier", "oauth_token" ->
        {
          :error,
          :reason
        }
      end)

      assert UserUsecase.create_user_from_twitter("oauth_verifier", "oauth_token") ==
               {:error, :reason}
    end

    test "userのAPIへのリクエストが失敗した場合、:cannot_store_userのerrorがかえる" do
      ExTwitterMock
      |> expect(:access_token, fn "oauth_verifier", "oauth_token" ->
        {
          :ok,
          %ExTwitter.Model.AccessToken{
            user_id: "user_id",
            oauth_token: "oauth_token",
            oauth_token_secret: "oauth_token_secret"
          }
        }
      end)
      |> expect(:user, fn "user_id" ->
        {
          :error,
          :reason
        }
      end)

      assert UserUsecase.create_user_from_twitter("oauth_verifier", "oauth_token") ==
               {:error, :reason}
    end

    test "APIへのリクエストが成功し、何かしらが起こりDBへの保存が失敗した場合、:cannot_store_userのerrorがかえる" do
      ExTwitterMock
      |> expect(:access_token, fn "oauth_verifier", "oauth_token" ->
        {
          :ok,
          %ExTwitter.Model.AccessToken{
            user_id: "user_id",
            oauth_token: "oauth_token",
            oauth_token_secret: "oauth_token_secret"
          }
        }
      end)
      |> expect(:user, fn "user_id" ->
        {
          :ok,
          %ExTwitter.Model.User{
            name: "name",
            screen_name: "screen_name"
          }
        }
      end)

      UserMock
      |> expect(:create_user, fn %{
                                   name: "name",
                                   twitter_id: "screen_name",
                                   oauth_token: "oauth_token",
                                   oauth_token_secret: "oauth_token_secret"
                                 } ->
        {:error, :cannot_store_user}
      end)

      assert UserUsecase.create_user_from_twitter("oauth_verifier", "oauth_token") ==
               {:error, :cannot_store_user}
    end
  end

  describe "get_user/1" do
    UserMock
    |> expect(:get_user, fn "id" ->
      {:ok,
       %User{
         name: "name",
         twitter_id: "screen_name",
         oauth_token: "oauth_token",
         oauth_token_secret: "oauth_token_secret"
       }}
    end)

    assert UserUsecase.get_user("id") ==
             {:ok,
              %User{
                name: "name",
                twitter_id: "screen_name",
                oauth_token: "oauth_token",
                oauth_token_secret: "oauth_token_secret"
              }}
  end
end
