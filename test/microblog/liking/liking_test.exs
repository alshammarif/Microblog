defmodule Microblog.LikingTest do
  use Microblog.DataCase

  alias Microblog.Liking

  describe "likes" do
    alias Microblog.Liking.Like

    @valid_attrs %{total: 42}
    @update_attrs %{total: 43}
    @invalid_attrs %{total: nil}

    def like_fixture(attrs \\ %{}) do
      {:ok, like} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Liking.create_like()

      like
    end

    test "list_likes/0 returns all likes" do
      like = like_fixture()
      assert Liking.list_likes() == [like]
    end

    test "get_like!/1 returns the like with given id" do
      like = like_fixture()
      assert Liking.get_like!(like.id) == like
    end

    test "create_like/1 with valid data creates a like" do
      assert {:ok, %Like{} = like} = Liking.create_like(@valid_attrs)
      assert like.total == 42
    end

    test "create_like/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Liking.create_like(@invalid_attrs)
    end

    test "update_like/2 with valid data updates the like" do
      like = like_fixture()
      assert {:ok, like} = Liking.update_like(like, @update_attrs)
      assert %Like{} = like
      assert like.total == 43
    end

    test "update_like/2 with invalid data returns error changeset" do
      like = like_fixture()
      assert {:error, %Ecto.Changeset{}} = Liking.update_like(like, @invalid_attrs)
      assert like == Liking.get_like!(like.id)
    end

    test "delete_like/1 deletes the like" do
      like = like_fixture()
      assert {:ok, %Like{}} = Liking.delete_like(like)
      assert_raise Ecto.NoResultsError, fn -> Liking.get_like!(like.id) end
    end

    test "change_like/1 returns a like changeset" do
      like = like_fixture()
      assert %Ecto.Changeset{} = Liking.change_like(like)
    end
  end
end
