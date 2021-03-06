defmodule PhoenixCrud.PostController do
  use PhoenixCrud.Web, :controller
  alias PhoenixCrud.Post
  alias PhoenixCrud.User

  plug :scrub_params, "post" when action in [:create, :update]

  def index(conn, _params) do
    posts = Repo.all(Post) |> Repo.preload([:user])
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    changeset = Post.changeset(%Post{})
    render(conn, "new.html", changeset: changeset,
      users: available_users)
  end

  def create(conn, %{"post" => post_params}) do
    Post.changeset(%Post{}, post_params)
    |> create_new_post(conn)
  end

  def show(conn, %{"id" => id}) do
    post = Repo.get!(Post, id) |> Repo.preload([:user])
    render(conn, "show.html", post: post)
  end

  def edit(conn, %{"id" => id}) do
    post = Repo.get!(Post, id) |> Repo.preload([:user])
    changeset = Post.changeset(post)
    render(conn, "edit.html", post: post,
      changeset: changeset, users: available_users)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Repo.get!(Post, id)
    changeset = Post.changeset(post, post_params)

    update_post(changeset, post, conn)
  end

  def delete(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)
    Repo.delete!(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: post_path(conn, :index))
  end

  defp create_new_post(changeset, conn) do
    case Repo.insert(changeset) do
      {:ok, _post} ->
        post_created_msg_and_redirected(conn)
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset,
          users: available_users)
    end
  end

  defp update_post(changeset, post, conn) do
    case Repo.update(changeset) do
      {:ok, post} ->
        update_conn_and_redirect(conn, post)
      {:error, changeset} ->
        render(conn, "edit.html",  post: post, changeset: changeset,
          users: available_users)
    end
  end

  defp post_created_msg_and_redirected(conn) do
    conn
    |> put_flash(:info, "Post created successfully.")
    |> redirect(to: post_path(conn, :index))
  end

  defp update_conn_and_redirect(conn, post) do
    conn
    |> put_flash(:info, "Post updated successfully.")
    |> redirect(to: post_path(conn, :show, post))
  end

  defp available_users do
    users = Repo.all(User)
    Enum.map(users, fn (user) -> { user.name, user.id } end)
  end
end
