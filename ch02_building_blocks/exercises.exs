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

