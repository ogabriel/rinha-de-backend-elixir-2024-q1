defmodule RinhaWeb.ClientController do
  use RinhaWeb, :controller

  alias Rinha.Bank
  alias Rinha.Bank.Client
  alias Rinha.Bank.Transaction

  alias Rinha.Repo
  import Ecto.Query

  action_fallback RinhaWeb.FallbackController

  def transacoes(conn, %{"id" => id} = params) do
    send_resp(conn, 422, id)
  end

  def extrato(conn, %{"id" => id}) do
    id = parse_id(id)

    if is_number(id) && id > 0 do
      with %Client{} = client <- Bank.extrato(id) do
        render(conn, :extrato, client: client)
      else
        _ -> send_resp(conn, 404, "")
      end
    else
      send_resp(conn, 404, "")
    end
  end

  defp parse_id(id) do
    case Integer.parse(id) do
      {id, _} -> id
      _ -> nil
    end
  end
end
