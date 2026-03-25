# Chapter 13: Running the System
#
# Topics:
# - OTP releases with `mix release`
# - Release configuration (config/runtime.exs)
# - Starting, stopping, and upgrading a release
# - Logging: Logger, log levels, backends
# - Debugging with IEx.pry and :debugger
# - Connecting to a running node: `mix release` remote shell
# - Tracing with :sys.trace and :recon_trace
# - Observer: :observer.start() for visual process inspection
# - System introspection: Process.list, :erlang.memory, etc.

# ---------------------------------------------------------------------------
# 13.1 Building a release
# ---------------------------------------------------------------------------

# From todo_system/:
#   MIX_ENV=prod mix release
#   _build/prod/rel/todo_system/bin/todo_system start

# ---------------------------------------------------------------------------
# 13.2 Logging
# ---------------------------------------------------------------------------

# require Logger
# Logger.info("Server started")
# Logger.warning("Slow query: #{inspect(query)}")
# Logger.error("Crash: #{inspect(reason)}")

# ---------------------------------------------------------------------------
# 13.3 Observer
# ---------------------------------------------------------------------------

# In IEx:
#   :observer.start()
# Opens a GUI showing process tree, memory, ETS tables, etc.

# ---------------------------------------------------------------------------
# 13.4 Tracing with :recon_trace (add :recon to deps)
# ---------------------------------------------------------------------------

# :recon_trace.calls({TodoServer, :handle_call, :_}, 10)
# — traces the next 10 calls to TodoServer.handle_call/3

