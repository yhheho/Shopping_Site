defmodule ShoppingSite.Order do
  use ShoppingSite.Web, :model

  schema "orders" do
    field :total, :integer

    belongs_to :user, ShoppingSite.User

    has_many :items, ShoppingSite.OrderItem, on_delete: :delete_all
    has_one :info, ShoppingSite.OrderInfo, on_delete: :delete_all

    timestamps()
  end

  @required_fields ~w(user_id total)
  @optional_fields ~w()

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields)
    |> cast_assoc(:info, required: true)
    |> validate_required([:user_id, :total])

  end
end
