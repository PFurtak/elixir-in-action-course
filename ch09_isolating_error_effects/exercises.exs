# Chapter 9: Isolating Error Effects
#
# Topics:
# - Supervision trees (nested supervisors)
# - Separating loosely related parts into separate subtrees
# - Rich process discovery: Registry
# - Via tuples for named processes
# - Registering database workers under a Registry
# - Supervising database workers with a DynamicSupervisor
# - Organizing the supervision tree
# - Starting processes dynamically
# - Using :temporary restart strategy for short-lived processes
# - "Let it crash": knowing when NOT to catch errors
# - Processes that must not crash (vs those that can)
# - Preserving state across restarts

# ---------------------------------------------------------------------------
# 9.1 Supervision tree sketch
#
#   TodoSystem.Application
#     ├── TodoDatabase.Supervisor
#     │   ├── Registry (for DB workers)
#     │   └── DynamicSupervisor (spawns DB workers on demand)
#     └── TodoCache.Supervisor
#         ├── Registry (for TodoServers)
#         └── DynamicSupervisor (spawns one TodoServer per list)
# ---------------------------------------------------------------------------

# See todo_system/ for the full implementation.

# ---------------------------------------------------------------------------
# 9.2 Registry experiment
# ---------------------------------------------------------------------------

# TODO: start a Registry in IEx and register/look up a process
#
#   {:ok, _} = Registry.start_link(name: MyRegistry, keys: :unique)
#   Registry.register(MyRegistry, "alice", nil)
#   Registry.lookup(MyRegistry, "alice")

