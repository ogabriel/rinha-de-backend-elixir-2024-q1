defmodule Rinha.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :valor, :integer
      add :tipo, :string
      add :descricao, :string
      add :realizada_em, :naive_datetime

      add :client_id, references(:clients, on_delete: :nothing)
    end

    create index(:transactions, [:client_id])
  end
end
