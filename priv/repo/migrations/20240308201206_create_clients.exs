defmodule Rinha.Repo.Migrations.CreateClients do
  use Ecto.Migration

  def change do
    create table(:clients) do
      add :limite, :integer
      add :saldo, :integer
    end
  end
end
