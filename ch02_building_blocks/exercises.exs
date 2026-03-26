# Chapter 2: Building Blocks
#
# Topics:
# - IEx basics
# - Variables and immutability
# - Basic types: integers, floats, atoms, booleans, nil
# - Strings and string interpolation
# - Tuples, lists, maps
# - Modules and named functions
# - Function arity and default arguments
# - Private functions (defp)
# - Imports, aliases, require
# - Module attributes (@)
# - Understanding the runtime: modules as bytecode

# ---------------------------------------------------------------------------
# 2.1 Variables
# ---------------------------------------------------------------------------

# Variables are untyped and immutable (rebinding creates a new binding)
# TODO: experiment with rebinding and see that the old value doesn't change

aircraft = "Hornet"
IO.puts(aircraft)
aircraft = "Warthog"
IO.puts(aircraft)

# ---------------------------------------------------------------------------
# 2.2 Basic types
# ---------------------------------------------------------------------------

# Atoms
# TODO: create some atoms and inspect them with `is_atom/1`

# Tuples
# TODO: create a {status, value} tuple and pattern-match it

# Lists
# TODO: create a list, use hd/1, tl/1, and Enum.at/2

# Maps
# TODO: create a map, access a key with map.key and map[:key]

# ---------------------------------------------------------------------------
# 2.3 Modules and functions
# ---------------------------------------------------------------------------

# Every function must reside in a module.
# \\ assigns default value to argument.
# Called via Calculator.add(5, 5)
# Default args generate both Calculator.add/1 and Calculator.add/2 arity at compile.
# ^ It is impossible to have a function take in a variable amount of arguments.
# defp creates private functions, can only be called from within the same module.
# |> operator chains functions together with return values
defmodule Calculator do
  def add(a, b \\ 0) do
    a + b
  end

  def double(a) do
    sum(a, a)
  end

  defp sum(a, b) do
    a + b
  end
end

Calculator.double(6) |> IO.puts()

# Calculator.sum(3, 9) |> IO.puts() #UndefinedFunctionError because private function called outside of module.

# Import & alias allows you to shorthand module calls.
# Import example:
defmodule TestImports do
  import IO

  def print_greeting() do
    puts("Salutations")
  end
end

TestImports.print_greeting()

# Alias example:
defmodule Arithmetic.Square do
  def square(a) do
    a * a
  end
end

defmodule AliasTest do
  alias Arithmetic.Square, as: Calc

  def print_square5 do
    # Shorter than calling Arithmetic.Square.square(5)
    Calc.square(5) |> IO.puts()
  end
end

AliasTest.print_square5()

defmodule Geometry do
  # TODO: implement area/1 for a circle given radius
  # hint: use :math.pi()
  def area({:circle, r}) do
    :math.pi() * r * r
  end

  # TODO: implement area/1 for a rectangle given {width, height}
  def area({:rectangle, w, h}) do
    w * h
  end
end

IO.inspect(Geometry.area({:circle, 3}))
IO.inspect(Geometry.area({:rectangle, 4, 5}))

# ---------------------------------------------------------------------------
# 2.4 Higher-order functions and lambdas
# ---------------------------------------------------------------------------

# TODO: write a lambda that doubles a number and call it
double = fn x -> x * 2 end
IO.inspect(double.(5))

# TODO: use Enum.map/2 to double every element in a list
