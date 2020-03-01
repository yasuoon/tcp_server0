defmodule TcpServer0.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Starts a worker by calling: TcpServer0.Worker.start_link(arg)
      # {TcpServer0.Worker, arg}
      {Task.Supervisor, name: TcpEchoServer.TaskSupervisor},
      Supervisor.child_spec({Task, fn -> TcpEchoServer.start() end},
        restart: :permanent)
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TcpServer0.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
