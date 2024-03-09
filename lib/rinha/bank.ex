defmodule Rinha.Bank do
  @moduledoc """
  The Bank context.
  """

  import Ecto.Query, only: [from: 2]

  alias Rinha.Repo
  alias Rinha.Bank.Client
  alias Rinha.Bank.Transaction

  def transacoes(id, transacao_params) do
    transacao = Transaction.parse(transacao_params, id)

    credito_ou_debito =
      if transacao.tipo == "c" do
        transacao.valor
      else
        -1 * transacao.valor
      end

    query = from(c in Client, where: c.id == ^id, lock: "FOR UPDATE")

    Repo.transaction(fn repo ->
      with [client] <- repo.all(query),
           novo_saldo <- client.saldo + credito_ou_debito,
           true <- novo_saldo >= -client.limite do
        client
        |> Ecto.Changeset.change(%{saldo: novo_saldo})
        |> repo.update

        repo.insert(transacao)

        %{saldo: novo_saldo, limite: client.limite}
      else
        [] -> repo.rollback(:not_found)
        _ -> repo.rollback(nil)
      end
    end)
  end

  def extrato(id) do
    transaction_query = from t in Transaction, order_by: [desc: t.id], limit: 10

    Repo.all(from c in Client, where: c.id == ^id, preload: [transactions: ^transaction_query])
  end
end
