defmodule MicroblogWeb.LikeController do
  use MicroblogWeb, :controller

  alias Microblog.Liking
  alias Microblog.Liking.Like

  action_fallback MicroblogWeb.FallbackController

  def index(conn, %{"post_id" => post_id}) do
    likes = Liking.list_post_likes(post_id)
    render(conn, "index.json", likes: likes)
  end


  def index(conn, _params) do
    likes = Liking.list_likes()
    render(conn, "index.json", likes: likes)
  end 

  def create(conn, %{"like" => like_params}) do
    with {:ok, %Like{} = like} <- Liking.create_like(like_params)
    do
      conn
      |> put_status(:created)
      |> put_resp_header("location", like_path(conn, :show, like))
      |> render("show.json", like: like)
    end
  end 

  def show(conn, %{"post_id" => post_id}) do
     count = Liking.total_likes(post_id) 
     render(conn, "show.json", count: count)
  end


  def show(conn, %{"id" => id}) do
    like = Liking.get_like!(id)
    render(conn, "show.json", like: like)
  end

  def update(conn, %{"id" => id, "like" => like_params}) do
    like = Liking.get_like!(id)

    with {:ok, %Like{} = like} <- Liking.update_like(like, like_params) do
      render(conn, "show.json", like: like)
    end
  end

  def delete(conn, %{"id" => id}) do
    like = Liking.get_like!(id)
    with {:ok, %Like{}} <- Liking.delete_like(like) do
      send_resp(conn, :no_content, "")
  end
 end 
end
