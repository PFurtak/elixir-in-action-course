# Chapter 11: Working with Components
#
# Topics:
# - OTP applications: what they are, how mix.exs defines them
# - Application callbacks: Application.start/2
# - Umbrella projects and splitting a system into components
# - Working with dependencies (mix.exs :deps)
# - Third-party libraries: adding to mix.exs, mix deps.get
# - Exposing HTTP interfaces: Plug / Cowboy (or Bandit)
# - Turning the TodoSystem into a proper OTP application
#
# Most of the work in this chapter happens in todo_system/.
# Use this file for scratch experiments.

# ---------------------------------------------------------------------------
# Adding HTTP with Plug (sketch — add to todo_system)
# ---------------------------------------------------------------------------

# In mix.exs deps:
#   {:plug_cowboy, "~> 2.0"}
#
# A minimal Plug router:
#
#   defmodule TodoWeb do
#     use Plug.Router
#
#     plug :match
#     plug :dispatch
#
#     get "/entries/:date" do
#       date = Date.from_iso8601!(date)
#       entries = TodoCache.server_process(conn.assigns.list_name)
#                 |> TodoServer.entries(date)
#       send_resp(conn, 200, inspect(entries))
#     end
#   end

