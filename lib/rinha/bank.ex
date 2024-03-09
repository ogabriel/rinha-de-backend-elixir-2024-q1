defmodule Rinha.Bank do
  @moduledoc """
  The Bank context.
  """

  import Ecto.Query, warn: false
  alias Rinha.Repo

  alias Rinha.Bank.Client
  alias Rinha.Bank.Transaction



  def extrato(id) do
    transaction_query = from t in Transaction, order_by: [desc: t.id], limit: 10

    Repo.one(from p in Client, where: p.id == ^id, preload: [transactions: ^transaction_query])
  end
end
