defmodule RinhaWeb.ClientController do
  use RinhaWeb, :controller

  alias Rinha.Bank

  def transacoes(conn, %{"id" => id} = params) do
    id = parse_id(id)

    if is_integer(id) && id > 0 && id < 6 do
      case Bank.transacoes(id, params) do
        {:ok, result} ->
          conn
          |> put_status(200)
          |> json(result)

        {:error, :not_found} ->
          send_resp(conn, 404, "")

        _ ->
          send_resp(conn, 422, "")
      end
    else
      send_resp(conn, 404, "")
    end
  end

  def extrato(conn, %{"id" => id}) do
    id = parse_id(id)

    if is_integer(id) && id > 0 && id < 6 do
      with [client] <- Bank.extrato(id) do
        render(conn, :extrato, client: client)
      else
        _ -> send_resp(conn, 404, "")
      end
    else
      send_resp(conn, 404, "")
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
