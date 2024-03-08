defmodule RinhaWeb.Router do
  use RinhaWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RinhaWeb do
    pipe_through :api

    resources "/clients", ClientController, except: [:new, :edit]
  end
end
