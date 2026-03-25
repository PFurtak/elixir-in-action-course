defmodule TodoServer do
  # Added in ch6 — wraps TodoList in a GenServer.
  # Extended in ch7 to persist via TodoDatabase.
  # Managed by a DynamicSupervisor in ch9.

  use GenServer

  # ---------------------------------------------------------------------------
  # Client API
  # ---------------------------------------------------------------------------

  def start_link(name) do
    GenServer.start_link(__MODULE__, name, name: global_name(name))
  end

  def add_entry(todo_server, entry) do
    GenServer.cast(todo_server, {:add_entry, entry})
  end

  def entries(todo_server, date) do
    GenServer.call(todo_server, {:entries, date})
  end

  def update_entry(todo_server, id, updater_fun) do
    GenServer.cast(todo_server, {:update_entry, id, updater_fun})
  end

  def delete_entry(todo_server, id) do
    GenServer.cast(todo_server, {:delete_entry, id})
  end

  # ---------------------------------------------------------------------------
  # Server callbacks
  # ---------------------------------------------------------------------------

  @impl true
  def init(name) do
    # TODO ch7: load initial state from TodoDatabase
    {:ok, {name, TodoList.new()}}
  end

  @impl true
  def handle_cast({:add_entry, entry}, {name, todo_list}) do
    new_list = TodoList.add_entry(todo_list, entry)
    # TODO ch7: persist via TodoDatabase
    {:noreply, {name, new_list}}
  end

  def handle_cast({:update_entry, id, updater_fun}, {name, todo_list}) do
    new_list = TodoList.update_entry(todo_list, id, updater_fun)
    {:noreply, {name, new_list}}
  end

  def handle_cast({:delete_entry, id}, {name, todo_list}) do
    new_list = TodoList.delete_entry(todo_list, id)
    {:noreply, {name, new_list}}
  end

  @impl true
  def handle_call({:entries, date}, _from, {name, todo_list}) do
    {:reply, TodoList.entries(todo_list, date), {name, todo_list}}
  end

  # ---------------------------------------------------------------------------
  # Helpers
  # ---------------------------------------------------------------------------

  defp global_name(name), do: {:global, {__MODULE__, name}}
end
