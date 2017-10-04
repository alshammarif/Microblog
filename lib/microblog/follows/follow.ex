defmodule Microblog.Follows.Follow do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Follows.Follow


  schema "follows" do
    field :follower, :id
    field :following, :id

    timestamps()
  end

  @doc false
  def changeset(%Follow{} = follow, attrs) do
    follow
    |> cast(attrs, [])
    |> validate_required([])
  end
end
