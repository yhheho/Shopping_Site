defmodule ShoppingSite.Order do
  use ShoppingSite.Web, :model
  # use Fsm, initial_state: :order_placed

  require IEx

  schema "orders" do
    field :token, :string
    field :total, :integer
    field :is_paid, :boolean, default: false
    field :payment_method, :string
    field :fsm_state, :string, default: "order_placed"

    belongs_to :user, ShoppingSite.User
    has_many :items, ShoppingSite.OrderItem, on_delete: :delete_all
    has_one :info, ShoppingSite.OrderInfo, on_delete: :delete_all

    timestamps()
  end

  @required_fields ~w(user_id total)
  @optional_fields ~w(token)

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
    |> put_token()
    |> cast_assoc(:info, required: true)
    |> validate_required([:user_id, :total])
  end

  def put_token(changeset) do
    case changeset.valid? do
      true ->
        put_change(changeset, :token, UUID.uuid4())
      false ->
        changeset
    end
  end

end
