defmodule Microblog.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :username, :string
      add :postdate, :date
      add :title, :string
      add :body, :text
      add :tags, :text
      add :usertag, :string

      timestamps()
    end

  end
end
