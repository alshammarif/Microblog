defmodule Microblog.Repo.Migrations.AlterPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :user_id, references(:users, on_delete: :delete_all)
      remove :username 
    end
  end
end
