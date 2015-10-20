defmodule PhoenixCrud.Post do
  use PhoenixCrud.Web, :model

  schema "posts" do
    field :content, :string
    field :title, :string
    belongs_to :user, PhoenixCrud.User

    timestamps
  end

  @required_fields ~w(content title user_id)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model |> cast(params, @required_fields, @optional_fields)
  end
end
