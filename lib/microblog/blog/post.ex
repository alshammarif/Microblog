defmodule Microblog.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Blog.Post


  schema "posts" do
    field :body, :string
    field :title, :string
    belongs_to :user, Microblog.Accounts.User

    timestamps()
  end
 

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:title, :body])
    |> validate_required([:body])
    |> assoc_constraint(:user)
  end
end
