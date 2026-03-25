defmodule TodoDatabase do
  # Added in ch7 — simple file-based persistence.
  # Extended in ch9 to use a pool of worker processes.

  use GenServer

  @db_folder "./persist"

  # ---------------------------------------------------------------------------
  # Client API
  # ---------------------------------------------------------------------------

  def start_link(db_folder \\ @db_folder) do
    GenServer.start_link(__MODULE__, db_folder, name: __MODULE__)
  end

  def store(key, data) do
    GenServer.cast(__MODULE__, {:store, key, data})
  end

  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  # ---------------------------------------------------------------------------
  # Server callbacks
  # ---------------------------------------------------------------------------

  @impl true
  def init(db_folder) do
    File.mkdir_p!(db_folder)
    {:ok, db_folder}
  end

  @impl true
  def handle_cast({:store, key, data}, db_folder) do
    file_name(db_folder, key) |> File.write!(:erlang.term_to_binary(data))
    {:noreply, db_folder}
  end

  @impl true
  def handle_call({:get, key}, _from, db_folder) do
    data =
      case File.read(file_name(db_folder, key)) do
        {:ok, contents} -> :erlang.binary_to_term(contents)
        _ -> nil
      end

    {:reply, data, db_folder}
  end

  # ---------------------------------------------------------------------------
  # Helpers
  # ---------------------------------------------------------------------------

  defp file_name(db_folder, key) do
    Path.join(db_folder, to_string(key))
  end
end
