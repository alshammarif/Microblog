defmodule Microblog.Follow do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Follow


  schema "follower" do
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Follow{} = follow, attrs) do
    follow
    |> cast(attrs, [])
    |> validate_required([])
  end
end
