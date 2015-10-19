defmodule PhoenixCrud.PageControllerTest do
  use PhoenixCrud.ConnCase

  test "GET /pages/index" do
    conn = get conn(), "/pages/index"
    assert html_response(conn, 200) =~ "index page Whatever!"
  end

  test "GET /pages/show" do
    conn = get conn(), "/pages/show"
    assert html_response(conn, 200) =~ "show page Whatever!"
  end

  test "GET /pages/unauthorized" do
    conn = get conn(), "/pages/unauthorized"
    assert html_response(conn, 200) =~ "admin layout hey"
  end
end
