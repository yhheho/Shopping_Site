defmodule ShoppingSite.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :account, :string, null: false
      add :username, :string, null: false
      add :password, :string, null: false
      add :encrypted_password, :string
      add :email, :string, null: false

      timestamps()
    end

  end
end
