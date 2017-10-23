defmodule Microblog.Liking do
  @moduledoc """
  The Liking context.
  """

  import Ecto.Query, warn: false
  alias Microblog.Repo

  alias Microblog.Liking.Like

  @doc """
  Returns the list of likes.

  ## Examples

      iex> list_likes()
      [%Like{}, ...]

  """
  def list_likes do
    Repo.all(Like)
     |> Microblog.Repo.preload([:user, :post])
  end

  def list_post_likes(post_id) do
    Repo.all(from l in Like, where: l.post_id == ^post_id)
     |> Microblog.Repo.preload([:user, :post])
  end

  def total_likes(post_id) do
    likes = Repo.all(from l in Like, where: l.post_id == ^post_id) 
    Repo.aggregate(likes, :count, :post_id)
     |> Microblog.Repo.preload([:user, :post])
  end
  
  def check_user(user_id, post_id) do 
     Repo.one(from l in Like, where: l.user_id == ^user_id, where: l.post_id == ^post_id)
     |> Microblog.Repo.preload([:user, :post])
  end    

  @doc """
  Gets a single like.

  Raises `Ecto.NoResultsError` if the Like does not exist.

  ## Examples

      iex> get_like!(123)
      %Like{}

      iex> get_like!(456)
      ** (Ecto.NoResultsError)

  """
  def get_like!(id) do 
    Repo.get!(Like, id) 
      |> Microblog.Repo.preload([:user, :post]) 
  end

  @doc """
  Creates a like.

  ## Examples

      iex> create_like(%{field: value})
      {:ok, %Like{}}

      iex> create_like(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_like(attrs \\ %{}) do
    %Like{}
    |> Microblog.Repo.preload([:user, :post])
    |> Like.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a like.

  ## Examples

      iex> update_like(like, %{field: new_value})
      {:ok, %Like{}}

      iex> update_like(like, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_like(%Like{} = like, attrs) do
    like
    |> Microblog.Repo.preload([:user, :post])
    |> Like.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Like.

  ## Examples

      iex> delete_like(like)
      {:ok, %Like{}}

      iex> delete_like(like)
      {:error, %Ecto.Changeset{}}

  """
  def delete_like(%Like{} = like) do
    Repo.delete(like)
    |> Microblog.Repo.preload([:user, :post])
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking like changes.

  ## Examples

      iex> change_like(like)
      %Ecto.Changeset{source: %Like{}}

  """
  def change_like(%Like{} = like) do
    Like.changeset(like, %{})
    |> Microblog.Repo.preload([:user, :post])
  end
end
