defmodule PhoenixCrud.User do
  use Ecto.Model

  schema "users" do
    field :name, :string
    field :email, :string
    field :bio, :string
    field :age, :integer

    timestamps
  end

  @required_fields ~w(name email)
  @optional_fields ~w(bio age)

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:bio, min: 2)
    |> validate_length(:bio, max: 140)
    |> validate_format(:email, ~r/@/)
  end
end
