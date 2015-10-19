defmodule PhoenixCrud.UserControllerTest do
  use PhoenixCrud.ConnCase
  alias PhoenixCrud.User

  test "GET /users" do
    conn = get conn(), "/users"
    assert html_response(conn, 200) =~ "Users CRUD!"
  end

  test "GET /users/:id" do
    user = get_user
    conn = get conn(), "/users/#{user.id}"
    assert html_response(conn, 200) =~ "name - #{user.name}"
  end

  test "GET /users/new" do
    conn = get conn(), "/users/new"
    assert html_response(conn, 200) =~ "New User"
  end

  @tag :skip
  test "POST /users" do
    conn = post conn(), "/users/new"
    assert html_response(conn, 200) =~ "New User"
  end

  test "GET /users/:id/edit" do
    user = get_user
    conn = get conn(), "/users/#{user.id}/edit"
    assert html_response(conn, 200) =~ "Edit User - #{user.name}"
  end

  test "POST /users/:id" do
    user = get_user
    conn = put conn(), "/users/#{user.id}", [user: %{name: "vtb"}]
    assert html_response(conn, 302) =~ "users/#{user.id}"
  end

  test "POST /users/:id Invalid" do
    user = get_user
    conn = put conn(), "/users/#{user.id}", [user: %{name: nil}]
    assert html_response(conn, 302) =~ "/users/#{user.id}/edit"
  end

  defp get_user do
    users = Repo.all(from _ in User, limit: 1)
    user = List.first(users)
  end
end
