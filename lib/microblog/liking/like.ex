defmodule Microblog.Liking.Like do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Liking.Like


  schema "likes" do
    belongs_to :post, Microblog.Blog.Post
    belongs_to :user, Microblog.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Like{} = like, attrs) do
    like
    |> cast(attrs, [:post_id, :user_id])
    |> validate_required([:post_id])
  end
end
