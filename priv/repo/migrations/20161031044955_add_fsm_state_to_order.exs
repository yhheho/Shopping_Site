defmodule ShoppingSite.Repo.Migrations.AddFsmStateToOrder do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      add :fsm_state, :string, default: "order_placed"
    end
  end
end
