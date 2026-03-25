# Chapter 7: Building a Concurrent System
#
# Topics:
# - Moving from a single process to multiple cooperating processes
# - Database server process (persistence abstraction)
# - Cache server / per-entry processes
# - Process registry: mapping keys to PIDs
# - Designing for concurrency: shared state vs per-entity processes
# - System-level thinking: which processes own which state?
# - Performance: parallelism and bottlenecks

# ---------------------------------------------------------------------------
# 7.1 The evolving Todo system
#
# By the end of this chapter the Todo system looks like:
#
#   TodoSystem.Application (supervisor — added in ch8)
#     ├── TodoServer (one per user list, GenServer, holds list in memory)
#     └── TodoDatabase (GenServer, delegates to worker pool for disk I/O)
#
# Work in todo_system/ for this chapter onward.
# ---------------------------------------------------------------------------

# ---------------------------------------------------------------------------
# 7.2 Quick experiments (run in IEx against todo_system)
# ---------------------------------------------------------------------------

# Start the app:
#   iex -S mix
#
# Create and use a server:
#   {:ok, pid} = TodoServer.start()
#   TodoServer.add_entry(pid, %{date: ~D[2024-01-19], title: "Dentist"})
#   TodoServer.entries(pid, ~D[2024-01-19])

