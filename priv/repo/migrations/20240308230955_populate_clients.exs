defmodule Rinha.Repo.Migrations.PopulateClients do
  use Ecto.Migration

  alias Rinha.Repo

  def up do
    Repo.insert_all("clients", [
      %{id: 1, limite: 100_000, saldo: 0},
      %{id: 2, limite: 80000, saldo: 0},
      %{id: 3, limite: 1_000_000, saldo: 0},
      %{id: 4, limite: 10_000_000, saldo: 0},
      %{id: 5, limite: 500_000, saldo: 0}
    ])
  end

  def down do
    Repo.delete_all("clients")
  end
end
