# Chapter 4: Data Abstractions
#
# Topics:
# - Abstracting with modules (data + functions in one module)
# - Using maps as the primary data structure
# - Structuring data with structs (defstruct)
# - Data transparency (structs are still maps)
# - Building composable abstractions (TodoList / TodoServer preview)
# - Immutable hierarchical updates (put_in, update_in, get_in)
# - Polymorphism with protocols
# - Implementing built-in protocols: String.Chars, Enumerable, Collectable

# ---------------------------------------------------------------------------
# 4.1 Map-based abstraction
# ---------------------------------------------------------------------------

defmodule TodoList do
  # Internal structure: %{next_id: integer, entries: %{id => entry}}
  def new(), do: %{next_id: 1, entries: %{}}

  def add_entry(todo_list, entry) do
    entry = Map.put(entry, :id, todo_list.next_id)
    new_entries = Map.put(todo_list.entries, todo_list.next_id, entry)
    %{todo_list | next_id: todo_list.next_id + 1, entries: new_entries}
  end

  def entries(todo_list, date) do
    todo_list.entries
    |> Map.values()
    |> Enum.filter(fn entry -> entry.date == date end)
  end

  def update_entry(todo_list, entry_id, updater_fun) do
    case Map.fetch(todo_list.entries, entry_id) do
      :error -> todo_list
      {:ok, old_entry} ->
        new_entry = updater_fun.(old_entry)
        new_entries = Map.put(todo_list.entries, entry_id, new_entry)
        %{todo_list | entries: new_entries}
    end
  end

  def delete_entry(todo_list, entry_id) do
    %{todo_list | entries: Map.delete(todo_list.entries, entry_id)}
  end
end

my_list =
  TodoList.new()
  |> TodoList.add_entry(%{date: ~D[2024-01-19], title: "Dentist"})
  |> TodoList.add_entry(%{date: ~D[2024-01-20], title: "Shopping"})
  |> TodoList.add_entry(%{date: ~D[2024-01-19], title: "Movies"})

IO.inspect(TodoList.entries(my_list, ~D[2024-01-19]))

# ---------------------------------------------------------------------------
# 4.2 Structs
# ---------------------------------------------------------------------------

# TODO: convert TodoList to use a struct instead of a plain map



# ---------------------------------------------------------------------------
# 4.3 Hierarchical updates
# ---------------------------------------------------------------------------

# TODO: experiment with put_in / update_in on nested maps



# ---------------------------------------------------------------------------
# 4.4 Protocols
# ---------------------------------------------------------------------------

# TODO: implement String.Chars for TodoList so inspect prints nicely


