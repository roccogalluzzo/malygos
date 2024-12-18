defmodule Malygos.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {ThousandIsland, port: 3724, handler_module: Malygos.Login.LoginServer}
    ]

    opts = [strategy: :one_for_one, name: Malygos.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def start_supervised() do
    Application.ensure_all_started(:malygos)
  end
end
