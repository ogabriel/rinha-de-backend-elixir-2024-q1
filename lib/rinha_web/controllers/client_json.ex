defmodule RinhaWeb.ClientJSON do
  def extrato(%{client: cliente}) do
    %{
      saldo: %{
        total: cliente.saldo,
        data_extrato: DateTime.now!("Etc/UTC"),
        limite: cliente.limite
      },
      ultimas_transacoes: for(transacao <- cliente.transactions, do: extrato_transacao(transacao))
    }
  end

  defp extrato_transacao(transacao) do
    %{
      valor: transacao.valor,
      tipo: transacao.tipo,
      descricao: transacao.descricao,
      realizada_em: transacao.inserted_at
    }
  end
end
