defmodule VanillaPhx.PostController do
  use VanillaPhx.Web, :controller
  alias VanillaPhx.Repo
  alias VanillaPhx.Posts

  def index(conn, _params) do
    render conn, "index.html"
  end

  def edit(conn, %{"id" => id}) do
    post = Repo.get(Posts, id)
    changeset = Posts.changeset(post)
    render conn, "edit.html", post: post, changeset: changeset
  end

  def update(conn, %{"id" => id, "posts" => %{"title" => title, "body" => body}}) do
  	post = Repo.get(Posts, id)
  	changeset = Posts.changeset(post, %{title: title, body: body})
  	Repo.update(changeset)
  	conn
  	|> put_layout(false)
    |> render("index.html")
  end
end
