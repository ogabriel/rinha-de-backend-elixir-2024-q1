defmodule Rinha.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :valor, :integer
      add :tipo, :string
      add :descricao, :string
      add :client_id, references(:clients, on_delete: :nothing)

      timestamps(type: :utc_datetime, updated_at: false)
    end

    create index(:transactions, [:client_id])
  end
end
