defmodule PhoenixCrud.UserController do
  use PhoenixCrud.Web, :controller
  import PhoenixCrud.Router.Helpers
  alias PhoenixCrud.User
  alias PhoenixCrud.Repo

  def index(conn, _params) do
    render conn, "index.html", users: Repo.all(User)
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    render conn, "show.html", user: user
  end

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"user" => params}) do
    changeset = User.changeset %User{}, params

    if changeset.valid? do
      user = Repo.insert!(changeset)
      redirect conn, to: user_path(conn, :show, user.id)
    else
      redirect conn, to: user_path(conn, :new)
    end
  end

  def edit(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    render conn, "edit.html", user: user
  end

  def update(conn, %{"id" => id, "user" => params}) do
    user = Repo.get!(User, id)
    changeset = User.changeset user, params

    if changeset.valid? do
      Repo.update(changeset)
      redirect conn, to: user_path(conn, :show, user.id)
    else
      redirect conn, to: user_path(conn, :edit, user: user)
    end
  end

  def destroy(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    Repo.delete!(user)

    redirect conn, user_path(conn, :index)
  end
end
