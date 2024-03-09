defmodule RinhaWeb.ClientController do
  use RinhaWeb, :controller

  alias Rinha.Bank

  def transacoes(conn, %{"id" => id} = params) do
    with id <- parse_id(id),
         true <- (is_integer(id) && id > 0) || {:error, :not_found},
         {:ok, result} <- Bank.transacoes(id, params) do
      conn
      |> put_status(200)
      |> json(result)
    else
      {:error, :not_found} -> send_resp(conn, 404, "")
      _ -> send_resp(conn, 422, "")
    end
  end

  def extrato(conn, %{"id" => id}) do
    with id <- parse_id(id),
         true <- is_integer(id) && id > 0,
         [client] <- Bank.extrato(id) do
      render(conn, :extrato, client: client)
    else
      _ -> send_resp(conn, 404, "")
    end
  end

  defp parse_id(id) do
    try do
      String.to_integer(id)
    rescue
      _ -> nil
    end
  end
end
