defmodule Rinha.Bank.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  alias Rinha.Bank.Client

  schema "transactions" do
    field :valor, :integer
    field :tipo, :string
    field :descricao, :string
    field :realizada_em, :naive_datetime

    belongs_to(:client, Client)
  end

  def parse(attrs, client_id) do
    %__MODULE__{}
    |> cast(attrs, [:valor, :tipo, :descricao], empty_values: [])
    |> put_change(:client_id, client_id)
    |> put_change(:realizada_em, NaiveDateTime.local_now())
    |> apply_changes
  end
end
