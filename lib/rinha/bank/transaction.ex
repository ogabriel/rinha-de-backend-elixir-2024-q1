defmodule Rinha.Bank.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  alias Rinha.Bank.Client

  schema "transactions" do
    field :valor, :integer
    field :tipo, :string
    field :descricao, :string

    belongs_to(:client, Client)

    timestamps(type: :utc_datetime, updated_at: false)
  end

  def parse(attrs, client_id) do
    %__MODULE__{}
    |> cast(attrs, [:valor, :tipo, :descricao], empty_values: [])
    |> change(%{client_id: client_id})
    |> apply_changes
  end
end
