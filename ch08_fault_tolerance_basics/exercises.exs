# Chapter 8: Fault Tolerance Basics
#
# Topics:
# - Runtime error types: :error, :exit, :throw
# - try/rescue, try/catch, after
# - Errors in concurrent systems
# - Linking processes: Process.link, spawn_link
# - Monitors: Process.monitor, :DOWN message
# - Supervisors: Supervisor module, child specs
# - Restart strategies: :one_for_one, :one_for_all, :rest_for_one
# - The Supervisor behaviour and child_spec/1
# - Restart frequency (max_restarts / max_seconds)
# - Adding a supervisor to the TodoSystem

# ---------------------------------------------------------------------------
# 8.1 Error handling
# ---------------------------------------------------------------------------

# TODO: demonstrate try/rescue for :error exceptions



# TODO: demonstrate try/catch for :exit and :throw



# ---------------------------------------------------------------------------
# 8.2 Process links
# ---------------------------------------------------------------------------

# TODO: spawn two linked processes and observe exit propagation



# ---------------------------------------------------------------------------
# 8.3 Monitors
# ---------------------------------------------------------------------------

# TODO: monitor a process and handle the :DOWN message



# ---------------------------------------------------------------------------
# 8.4 Supervisor
# ---------------------------------------------------------------------------

# See todo_system/lib/todo_system/application.ex for the supervisor tree.
# The supervisor added in ch8 looks like:
#
#   children = [
#     {TodoDatabase, "persist/"},
#     TodoServer               # just one server for now
#   ]
#
# TODO: add a basic supervisor to todo_system


