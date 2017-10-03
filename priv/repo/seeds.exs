# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Microblog.Repo.insert!(%Microblog.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Microblog.Repo

alias Microblog.Accounts.User
repo.delete_all(User)

Repo.insert!(%User{username: "pigeon_boy", email: "mike@example.com"})
Repo.insert!(%User{username: "ana-tony", email: "louis@example.com"})

alias Microblog.Blog.Post
repo.delete_all(Post)

Repo.insert!(%Post{username: "pigeon_boy", title: "nothing", body: "nothing to see here"})
Repo.insert!(%Post{username: "ana-tony", title: "everything", body: "everything to see here"})
