defmodule Microblog.Liking.Like do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Liking.Like


  schema "likes" do
    field :total, :integer
    belongs_to :post_id, Microblog.Blog.Post
    has_many :user_id, Microblog.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Like{} = like, attrs) do
    like
    |> cast(attrs, [:post_id, :user_id])
    |> validate_required([:post_id])
    |> assoc_constraint([:post_id, :user_id])
  end
end
