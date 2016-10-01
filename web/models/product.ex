defmodule ShoppingSite.Product do
  use ShoppingSite.Web, :model

  schema "products" do
    field :title, :string
    field :description, :string
    field :quantity, :integer
    field :price, :integer

    timestamps()
  end

  @required_fields ~w(title description quantity price)
  @optional_fields ~w()

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_required([:title, :description, :quantity, :price])
    |> validate_length(:description, max: 200)
  end
end
