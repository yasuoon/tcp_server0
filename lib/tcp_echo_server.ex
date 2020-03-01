defmodule TcpEchoServer do
  @moduledoc """
  Documentation for `TcpEchoServer`.
  """

  @doc """
  create listen socket
  """
  def listen(port) do
    {:ok, sock} = :gen_tcp.listen(port,
      [:binary, active: false, reuseaddr: true, backlog: 10, packet: :line])
    sock
  end

  @doc """
  accept loop
  """
  def loop_acceptor(sock) do
    {:ok, conn} = :gen_tcp.accept(sock)
    {:ok, pid} = Task.Supervisor.start_child(TcpEchoServer.TaskSupervisor, fn ->
      serve(conn) end)
    :ok = :gen_tcp.controlling_process(conn, pid)
    loop_acceptor(sock)
  end

  def start() do
    listen(4000)
    |> loop_acceptor()
  end

  defp serve(sock) do
    read_line(sock)
    |> write_line(sock)

    serve(sock)
  end

  defp read_line(sock) do
    {:ok, data} = :gen_tcp.recv(sock, 0)
    IO.inspect({:read, :inet.peername(sock), data})
    data
  end

  defp write_line(line, sock) do
    IO.inspect({:write, :inet.peername(sock), line})
    :gen_tcp.send(sock, line)
  end
end
