defmodule DbConn do
  def connect do
    {:ok, pid} = :mysql.start_link([
      host: {192, 168, 56, 1},
      user: "yas",
      password: "yas",
      database: "yas",
    ])
    table = "test_id"
    {pid, table}
  end

  def show_list({pid, table}) do
    :mysql.query(pid, "SELECT * FROM #{table}")
  end

  def insert({pid, table}, key, name) do
    :mysql.query(pid, "INSERT INTO #{table} VALUES(#{key}, '#{name}')")
  end

  def update_name({pid, table}, key, name) do
    query = "UPDATE #{table} SET name='#{name}' WHERE id=#{key}"
    :mysql.query(pid, query)
  end

  def delete({pid, table}, key) do
    query = "DELETE FROM #{table} WHERE id=#{key}"
    :mysql.query(pid, query)
  end

  def stop({pid, _}) do
    :mysql.stop(pid)
  end
end
