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

Repo.insert!(%User{email: "admin@example.com", is_admin?: true})
Repo.insert!(%User{email: "alshammarif@example.com", is_admin?: false})

alias Microblog.Blog.Post
repo.delete_all(Post)

Repo.insert!(%Post{username: "pigeon_boy", postdate: 02/10/2017, title: "nothing to see here", 
body: "There is absolutely nothing to see here" tags: "nothing"})
