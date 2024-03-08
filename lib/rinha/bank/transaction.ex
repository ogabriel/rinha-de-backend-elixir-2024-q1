defmodule Rinha.Bank.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transactions" do
    field :valor, :integer
    field :tipo, :string
    field :descriao, :string
    field :client_id, :id

    timestamps(type: :utc_datetime, updated_at: false)
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:valor, :tipo, :descriao], empty_values: [])
    |> validate_required([:valor, :tipo, :descriao])
  end
end
