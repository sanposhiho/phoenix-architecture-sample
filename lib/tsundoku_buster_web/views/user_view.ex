defmodule TsundokuBusterWeb.UserView do
  use TsundokuBusterWeb, :view
  alias TsundokuBusterWeb.UserView

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("authenticate.json", %{authorize_url: authorize_url}) do
      %{data: %{authorize_url: authorize_url}}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      name: user.name,
      twitter_id: user.twitter_id,
      created_at: user.created_at,
      updated_at: user.updated_at}
  end
end
