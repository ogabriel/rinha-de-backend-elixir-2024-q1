defmodule RinhaWeb.ClientController do
  use RinhaWeb, :controller

  alias Rinha.Bank
  alias Rinha.Bank.Client
  alias Rinha.Bank.Transaction

  alias Rinha.Repo
  import Ecto.Query

  action_fallback RinhaWeb.FallbackController
end
