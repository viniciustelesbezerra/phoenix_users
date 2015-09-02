defmodule PhoenixCrud.UserView do
  use PhoenixCrud.Web, :view

  def users_keys(users) do
    Enum.map(users, fn(u) -> u end)
  end
end
