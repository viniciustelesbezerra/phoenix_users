defmodule PhoenixCrud.PageController do
  use PhoenixCrud.Web, :controller

  def show(conn, %{"page" => "unauthorized"}) do
    conn
    |> put_layout("admin.html")
    |> render "index.html", page: "unauthorized"
  end

  def show(conn, %{"page" => page}) do
    render conn, "show.html", page: page
  end
end
