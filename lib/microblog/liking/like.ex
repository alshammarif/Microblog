defmodule Microblog.Liking.Like do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Liking.Like


  schema "likes" do
    field :total, :integer
    belongs_to :post_id, :id
    has_many :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Like{} = like, attrs) do
    like
    |> cast(attrs, [:total])
    |> validate_required([:total])
  end
end
