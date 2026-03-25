defmodule TodoSystem.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # ch7: TodoDatabase persists lists to disk
      # {TodoDatabase, "./persist"},

      # ch9: TodoCache manages per-list TodoServer processes dynamically
      # TodoCache,
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TodoSystem.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
