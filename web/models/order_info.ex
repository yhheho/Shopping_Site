defmodule ShoppingSite.OrderInfo do
  use ShoppingSite.Web, :model

  schema "order_infos" do
    field :billing_name, :string
    field :billing_address, :string
    field :shipping_name, :string
    field :shipping_address, :string
    belongs_to :order, ShoppingSite.Order

    timestamps()
  end

  @required_fields ~w(billing_name billing_address shipping_name shipping_address)
  @optional_fields ~w()

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields)
    |> validate_required([:billing_name, :billing_address, :shipping_name, :shipping_address])
  end
end
