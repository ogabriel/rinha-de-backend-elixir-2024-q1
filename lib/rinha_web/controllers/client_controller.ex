defmodule RinhaWeb.ClientController do
  use RinhaWeb, :controller

  alias Rinha.Bank
  alias Rinha.Bank.Client
  alias Rinha.Bank.Transaction

  alias Rinha.Repo
  import Ecto.Query

  def transacoes(conn, %{"id" => id} = params) do
    id = parse_id(id)

    if is_integer(id) && id > 0 && id < 6 do
      if validate_params(params) do
        case Bank.transacoes(id, params) do
          {:ok, result} ->
            render(conn, :transacoes, result: result)

          _ ->
            conn
            |> resp(422, nil)
            |> send_resp
            |> halt
        end
      else
        conn
        |> resp(422, nil)
        |> send_resp
        |> halt
      end
    else
      conn
      |> resp(404, nil)
      |> send_resp
      |> halt
    end
  end

  defp validate_params(params) do
    is_integer(params["valor"]) &&
      params["valor"] > 0 &&
      params["tipo"] in ["c", "d"] &&
      is_binary(params["descricao"]) &&
      validate_descricao(String.length(params["descricao"]))
  end

  defp validate_descricao(descricao_tamanho) do
    descricao_tamanho > 0 && descricao_tamanho < 11
  end

  def extrato(conn, %{"id" => id}) do
    id = parse_id(id)

    if is_integer(id) && id > 0 && id < 6 do
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
