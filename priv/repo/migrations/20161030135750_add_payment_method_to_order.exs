defmodule ShoppingSite.Repo.Migrations.AddPaymentMethodToOrder do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      add :payment_method, :string
    end
  end
end
