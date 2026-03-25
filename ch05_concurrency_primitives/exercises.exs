# Chapter 5: Concurrency Primitives
#
# Topics:
# - BEAM processes: lightweight, isolated, share nothing
# - spawn/1 and spawn/3
# - Sending and receiving messages (send/receive)
# - Process mailboxes
# - Synchronous (call) vs asynchronous (cast) messaging patterns
# - Building a stateful server process with recursion
# - Process registration (Process.register / via atoms)
# - Runtime considerations: process limits, message queue buildup

# ---------------------------------------------------------------------------
# 5.1 Spawning processes
# ---------------------------------------------------------------------------

# TODO: spawn a process that prints a message
spawn(fn -> IO.puts("Hello from process #{inspect(self())}") end)

# ---------------------------------------------------------------------------
# 5.2 Message passing
# ---------------------------------------------------------------------------

# TODO: implement a simple echo server
defmodule EchoServer do
  def start do
    spawn(fn -> loop() end)
  end

  defp loop do
    receive do
      {:echo, caller, message} ->
        send(caller, {:ok, message})
        loop()
    end
  end
end

pid = EchoServer.start()
send(pid, {:echo, self(), "hello"})

receive do
  {:ok, msg} -> IO.puts("Echo: #{msg}")
end

# ---------------------------------------------------------------------------
# 5.3 Stateful server process
# ---------------------------------------------------------------------------

# TODO: implement a stateful key-value server
# It should handle: {:put, key, value} and {:get, caller, key}
defmodule KeyValueStore do
  def start do
    spawn(fn -> loop(%{}) end)
  end

  defp loop(state) do
    receive do
      {:put, key, value} ->
        loop(Map.put(state, key, value))

      {:get, caller, key} ->
        send(caller, Map.get(state, key))
        loop(state)
    end
  end
end

kv = KeyValueStore.start()
send(kv, {:put, :name, "Alice"})
send(kv, {:get, self(), :name})

receive do
  name -> IO.puts("Got: #{name}")
end

# ---------------------------------------------------------------------------
# 5.4 Registered processes
# ---------------------------------------------------------------------------

# TODO: register a process under a name and communicate with it by name


