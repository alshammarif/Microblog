defmodule MicroblogWeb.SessionController do
  use MicroblogWeb, :controller

  alias Microblog.Accounts

  def get_and_auth_user(email, password) do
    user = Accounts.get_user_by_email!(email)
    case Comeonin.Argon2.check_pass(user, password) do 
	{:ok, user} -> user
	_else -> nil
    end
  end

  def login(conn, %{"email" => email, "password" => password}) do
    user = get_and_auth_user(email, password)
    
    if user do
      conn
      |> put_session(:user_id, user.id)
      |> put_flash(:info, "Logged in as #{user.username}")
      |> redirect(to: MicroblogWeb.Router.Helpers.post_path(MicroblogWeb.Endpoint, :index))
    else
      conn
      |> put_session(:user_id, nil)
      |> put_flash(:error, "No such user")
      |> put_flash(:error, "Bad email/password")
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
