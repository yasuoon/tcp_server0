defmodule AppState do
  use Agent

  def start_link(init_value) do
    Agent.start_link(fn -> init_value end, name: __MODULE__)
  end

  def value do
    Agent.get(__MODULE__, &(&1))
  end

  def update(f) do
    Agent.update(__MODULE__, f)
  end

  def stop do
    Agent.stop(__MODULE__)
  end
end
