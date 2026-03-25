# Chapter 12: Building a Distributed System
#
# Topics:
# - BEAM distribution primitives
# - Starting named nodes: --name / --sname flags
# - Connecting nodes: Node.connect/1, Node.list/0
# - Remote message passing: send({name, node}, msg)
# - Remote spawn: Node.spawn/2
# - Global process registration: :global.register_name
# - Links and monitors across nodes
# - Designing a distributed Todo cache
# - Replicating state across nodes
# - Network partitions and split-brain detection
# - :net_kernel, :net_adm helpers

# ---------------------------------------------------------------------------
# 12.1 Starting a two-node cluster (run in two terminals)
# ---------------------------------------------------------------------------

# Terminal 1:
#   iex --sname node1@localhost -S mix
#
# Terminal 2:
#   iex --sname node2@localhost -S mix
#
# In either IEx:
#   Node.connect(:node2@localhost)  # or node1
#   Node.list()

# ---------------------------------------------------------------------------
# 12.2 Remote message passing experiment
# ---------------------------------------------------------------------------

# On node1 — register a process:
#   pid = spawn(fn -> receive do msg -> IO.inspect(msg) end end)
#   Process.register(pid, :listener)
#
# On node2 — send to it:
#   send({:listener, :node1@localhost}, "hello from node2")

# ---------------------------------------------------------------------------
# 12.3 Distributed Todo cache sketch
# ---------------------------------------------------------------------------

# The book builds a hashing-based distribution strategy:
# list_name |> :erlang.phash2(Node.list() |> length()) => picks a node
# Then forwards the request to the chosen node's TodoCache.

