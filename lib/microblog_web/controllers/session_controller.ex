defmodule MicroblogWeb.SessionController do
  use MicroblogWeb, :controller

  alias Microblog.Accounts

  def login(conn, %{"email" => email}) do
    user = Accounts.get_user_by_email!(email)

    if user do
      conn
      |> put_session(:user_id, user.id)
      |> put_flash(:info, "Logged in as #{user.username}")
      |> redirect(to: MicroblogWeb.Router.Helpers.post_path(MicroblogWeb.Endpoint, :index))
    else
      conn
      |> put_session(:user_id, nil)
      |> put_flash(:error, "No such user")
      |> redirect(to: MicroblogWeb.Router.Helpers.post_path(MicroblogWeb.Endpoint, :index))
    end
  end
  def logout(conn, _params) do
    conn
    |> put_session(:user_id, nil)
    |> put_flash(:info, "Logged out")
    |> redirect(to: MicroblogWeb.Router.Helpers.post_path(MicroblogWeb.Endpoint, :index))
  end
end
