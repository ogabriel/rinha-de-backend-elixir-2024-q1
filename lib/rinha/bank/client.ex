defmodule Rinha.Bank.Client do
  use Ecto.Schema

  alias Rinha.Bank.Transaction

  schema "clients" do
    field :limite, :integer
    field :saldo, :integer

    has_many(:transactions, Transaction)
  end
end
