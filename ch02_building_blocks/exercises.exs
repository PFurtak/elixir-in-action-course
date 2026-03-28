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
# Best use is for named constants, ie. variable = :some_atom
:an_atom
:red_chili
:"atom using spaces"

# An atom can be aliased by omitting the :, ie "AnAtom" is then called by Elixir.AnAtom
AnAtom
# true
AnAtom == :"Elixir.AnAtom" |> IO.puts()

# Tuples
# TODO: create a {status, value} tuple and pattern-match it
# Best used for small fixed sized number of elements, dynamically sized collections use lists
# Modifying a tuple always creates a shallow copy. rebinding makes the old values garbage collectable
person = {"Patrick", 36}
age = elem(person, 1) |> IO.puts()
name = elem(person, 0) |> IO.puts()
# creates new tuple w/ the new value (use IO.inspect() for printing values other than strings)
birthday_increment = put_elem(person, 1, 37) |> IO.inspect()
# original tuple left unmodified
IO.inspect(person)

# Lists
# TODO: create a list, use hd/1, tl/1, and Enum.at/2
# Work like singly linked lists and must be traversed
# O(n) operations for most like length()
best_final_fantasies = [6, 7, 10, 16]
# 4
length(best_final_fantasies) |> IO.puts()
# 7, index starts at 0
my_favorite = Enum.at(best_final_fantasies, 1) |> IO.puts()
# false
(8 in best_final_fantasies) |> IO.puts()
# [6, 7, 10, 15]
update_bests = List.replace_at(best_final_fantasies, 3, 15) |> IO.inspect()
# concat lists with ++ operator
([1, 2, 3] ++ [4, 5, 6] ++ [7, 8, 9]) |> IO.inspect()
# IMPORTANT NOTE: LISTS ARE A RECURSIVE COLLECTION OF HEAD and TAIL PAIRS:
[1 | [2 | [3 | []]]] == [1, 2, 3]

# Maps
# TODO: create a map, access a key with map.key and map[:key]
# Dynamic empty map:
%{}
squares = %{1 => 1, 2 => 4, 3 => 9} |> IO.inspect()
new_up_squares = Map.new([{1, 1}, {2, 4}, {3, 9}]) |> IO.inspect()
IO.inspect(squares[2])
IO.inspect(squares[4])
# Can also access via Map.get/2 | Map.get/3 allows you to define a default value if return is nil:
Map.get(squares, 2) |> IO.puts()
Map.get(squares, 4, :not_found) |> IO.puts()
# Map.fetch to test if an element exists:
Map.fetch(squares, 1) |> IO.inspect()
Map.fetch(squares, 4) |> IO.inspect()
# Raise an exception if the element does not exist, continue if it does
# Map.fetch!(squares, 4) returns (KeyError)
# store a new element via Map.put/3
squares = Map.put(squares, 4, 16) |> IO.inspect()

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
