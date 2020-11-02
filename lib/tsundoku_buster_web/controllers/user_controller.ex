defmodule TsundokuBusterWeb.UserController do
  use TsundokuBusterWeb, :controller

  alias TsundokuBuster.Database.User, as: UserRepo
  alias TsundokuBuster.Usecase.User, as: UserUsecase
  alias TsundokuBuster.Schema.User

  action_fallback TsundokuBusterWeb.FallbackController

  def authenticate(conn, _) do
    with {:ok, authorize_url} <- UserUsecase.get_authorize_url() do
      render(conn, "authenticate.json", authorize_url: authorize_url)
    end
  end

  def callback(conn, %{"oauth_verifier" => oauth_verifier, "oauth_token" => oauth_token}) do
    with {:ok, %User{} = user} <- UserUsecase.create_user_from_twitter(oauth_verifier, oauth_token) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- UserUsecase.get_user(id) do
      render(conn, "show.json", user: user)
    end
  end

  def update(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- UserUsecase.update_user(id) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, _} <- UserUsecase.delete_user(id) do
      send_resp(conn, :no_content, "")
    end
  end
end
