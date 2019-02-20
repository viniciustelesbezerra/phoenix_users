defmodule PhoenixCrud.UserController do
  use PhoenixCrud.Web, :controller
  import PhoenixCrud.Router.Helpers
  alias PhoenixCrud.User
  alias PhoenixCrud.Repo

  plug :scrub_params, "post" when action in [:create, :update]

  def index(conn, _params) do
    render conn, "index.html", users: Repo.all(User)
  end

  def show(conn, %{"id" => id}) do
    user = get_user(id)
    render conn, "show.html", user: user
  end

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset %User{}, user_params

    if changeset.valid? do
      user = Repo.insert!(changeset)
      redirect conn, to: user_path(conn, :show, user.id)
    else
      redirect conn, to: user_path(conn, :new)
    end
  end

  def edit(conn, %{"id" => id}) do
    user = get_user(id)
    render conn, "edit.html", user: user
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    get_user(id)
    |> User.changeset(user_params)
    |> update_change_set(conn, id)
  end

  def destroy(conn, %{"id" => id}) do
    user = get_user(id)
    Repo.delete!(user)

    redirect conn, user_path(conn, :index)
  end

  defp update_change_set(changeset, conn, user_id) do
    if changeset.valid? do
      Repo.update(changeset)
      redirect conn, to: user_path(conn, :show, user_id)
    else
      redirect conn, to: user_path(conn, :edit, user_id)
    end
  end

  defp get_user(id) do
    user = Repo.get!(User, id)
  end
end
