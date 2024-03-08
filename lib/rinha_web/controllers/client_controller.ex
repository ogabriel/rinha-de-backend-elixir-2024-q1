defmodule RinhaWeb.ClientController do
  use RinhaWeb, :controller

  alias Rinha.Bank
  alias Rinha.Bank.Client

  action_fallback RinhaWeb.FallbackController

  def index(conn, _params) do
    clients = Bank.list_clients()
    render(conn, :index, clients: clients)
  end

  def create(conn, %{"client" => client_params}) do
    with {:ok, %Client{} = client} <- Bank.create_client(client_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/clients/#{client}")
      |> render(:show, client: client)
    end
  end

  def show(conn, %{"id" => id}) do
    client = Bank.get_client!(id)
    render(conn, :show, client: client)
  end

  def update(conn, %{"id" => id, "client" => client_params}) do
    client = Bank.get_client!(id)

    with {:ok, %Client{} = client} <- Bank.update_client(client, client_params) do
      render(conn, :show, client: client)
    end
  end

  def delete(conn, %{"id" => id}) do
    client = Bank.get_client!(id)

    with {:ok, %Client{}} <- Bank.delete_client(client) do
      send_resp(conn, :no_content, "")
    end
  end
end
