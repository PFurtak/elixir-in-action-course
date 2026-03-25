# Chapter 10: Beyond GenServer
#
# Topics:
# - Task: fire-and-forget or awaited async work
#   - Task.async / Task.await
#   - Task.start (non-awaited, supervised)
#   - Task.Supervisor
# - Agent: simple stateful process with a thin wrapper
#   - Agent.start_link, Agent.get, Agent.update, Agent.get_and_update
# - ETS (Erlang Term Storage):
#   - :ets.new, :ets.insert, :ets.lookup, :ets.delete
#   - Concurrency characteristics (reads without locking)
#   - Using ETS as a cache to reduce GenServer bottlenecks

# ---------------------------------------------------------------------------
# 10.1 Tasks
# ---------------------------------------------------------------------------

# Awaited task — like a Future / Promise
result =
  Task.async(fn ->
    :timer.sleep(100)
    42
  end)
  |> Task.await()

IO.inspect(result)

# TODO: run multiple tasks in parallel and await all of them
tasks = Enum.map(1..5, fn i -> Task.async(fn -> i * i end) end)
results = Task.await_many(tasks)
IO.inspect(results)

# ---------------------------------------------------------------------------
# 10.2 Agents
# ---------------------------------------------------------------------------

{:ok, counter} = Agent.start_link(fn -> 0 end)
Agent.update(counter, fn n -> n + 1 end)
Agent.update(counter, fn n -> n + 1 end)
IO.inspect(Agent.get(counter, fn n -> n end))

# TODO: implement a simple cache module backed by an Agent



# ---------------------------------------------------------------------------
# 10.3 ETS
# ---------------------------------------------------------------------------

# TODO: create an ETS table, insert, and look up entries
table = :ets.new(:my_cache, [:set, :public])
:ets.insert(table, {:name, "Alice"})
IO.inspect(:ets.lookup(table, :name))

# TODO: compare GenServer vs ETS for read-heavy workloads in comments


