defmodule Rinha.Bank.Client do
  use Ecto.Schema
  import Ecto.Changeset

  alias Rinha.Bank.Transaction

  schema "clients" do
    field :limite, :integer
    field :saldo, :integer

    has_many(:transactions, Transaction)
  end

  @doc false
  def changeset(client, attrs) do
    client
    |> cast(attrs, [:limite, :saldo], empty_values: [])
    |> validate_required([:limite, :saldo])
  end
end
