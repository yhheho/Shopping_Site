defmodule ShoppingSite.User do
  use ShoppingSite.Web, :model

  schema "users" do
    field :account, :string
    field :username, :string
    field :password, :string
    field :encrypted_password, :string
    field :email, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:account, :username, :password, :encrypted_password, :email])
    |> validate_required([:account, :username, :password, :encrypted_password, :email])
    |> validate_length(:password, min: 6, max: 20)
  end
end
