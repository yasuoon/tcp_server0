defmodule TcpServer0Test do
  use ExUnit.Case
  doctest TcpServer0

  test "greets the world" do
    assert TcpServer0.hello() == :world
  end
end
