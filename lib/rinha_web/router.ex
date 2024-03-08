defmodule RinhaWeb.Router do
  use RinhaWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/clients", RinhaWeb do
    pipe_through :api

    post("/:id/transacoes", ClientController, :transacoes)
    get("/:id/extrato", ClientController, :extrato)
  end
end
