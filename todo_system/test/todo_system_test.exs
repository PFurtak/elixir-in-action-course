defmodule TodoSystemTest do
  use ExUnit.Case
  doctest TodoSystem

  test "greets the world" do
    assert TodoSystem.hello() == :world
  end
end
