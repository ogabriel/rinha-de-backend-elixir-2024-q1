defmodule Rinha.Bank.Client do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clients" do
    field :limite, :integer
    field :saldo, :integer
  end

  @doc false
  def changeset(client, attrs) do
    client
    |> cast(attrs, [:limite, :saldo], empty_values: [])
    |> validate_required([:limite, :saldo])
  end
end
