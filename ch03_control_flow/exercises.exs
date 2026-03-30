# Chapter 3: Control Flow
#
# Topics:
# - Pattern matching: the = operator, matching tuples/lists/maps/binaries
# - Match operator vs variable rebinding
# - The pin operator (^)
# - Multiclause functions
# - Guards (when)
# - Conditionals: if/unless, cond, case
# - with/1 for chained pattern matches
# - Comprehensions (for)
# - Recursion: writing recursive functions, tail-call optimization
# - The pipe operator (|>)

# ---------------------------------------------------------------------------
# 3.1 Pattern matching
# ---------------------------------------------------------------------------

# TODO: pattern match a tuple to extract values
{status, value} = {:ok, 42}
IO.inspect(status)
IO.inspect(value)

# TODO: match a list head and tail
[head | tail] = [1, 2, 3, 4]
IO.inspect(head)
IO.inspect(tail)

# TODO: use the pin operator to assert an existing value
expected = :ok
{^expected, result} = {:ok, "data"}
IO.inspect(result)

# ---------------------------------------------------------------------------
# 3.2 Multiclause functions and guards
# ---------------------------------------------------------------------------

defmodule Factorial do
  def of(0), do: 1
  def of(n) when n > 0, do: n * of(n - 1)
end

IO.inspect(Factorial.of(5))
IO.inspect(Factorial.of(0))

# Multiclause
defmodule Geometry do
  def area({:square, a}) do
    a * a
  end

  def area({:rectangle, a, b}) do
    a * b
  end

  def area({:circle, r}) do
    r * r * 3.14
  end

  # default clause, must be last as the arguments
  # are checked top to bottom during runtime
  def area(unknown) do
    {:error, {:unknown_shape, unknown}}
  end
end

Geometry.area({:square, 5}) |> IO.puts()
Geometry.area({:rectangle, 3, 5}) |> IO.puts()
Geometry.area({:circle, 7}) |> IO.puts()
Geometry.area({:hexagon, 8}) |> IO.inspect()

# Guards
# 'when' after the argument list is a clause.
# This conditional must be satisfied to pattern match.
# '<' and '>' can evaluate types that are not numbers,
# it will compare a string to bit value; thus causing :positive
# return of any non number. is_number() is an additional guard
# against this.
defmodule TestNum do
  def test(num) when not is_number(num) do
    {:error, :not_a_number, num}
  end

  def test(num) when num < 0 do
    :negative
  end

  def test(num) when num === 0 do
    :zero
  end

  def test(num) when num > 0 do
    :positive
  end
end

TestNum.test(-6) |> IO.puts()
TestNum.test(0) |> IO.puts()
TestNum.test(4) |> IO.puts()
TestNum.test("yolo") |> IO.inspect()

# ---------------------------------------------------------------------------
# 3.3 case, cond, if
# ---------------------------------------------------------------------------

# TODO: rewrite Factorial using a case expression instead of multiple clauses

# ---------------------------------------------------------------------------
# 3.4 The pipe operator
# ---------------------------------------------------------------------------

# TODO: refactor a nested function call to use |>
# e.g. Enum.sum(Enum.map([1,2,3], fn x -> x * x end))
result =
  [1, 2, 3]
  |> Enum.map(fn x -> x * x end)
  |> Enum.sum()

IO.inspect(result)

# ---------------------------------------------------------------------------
# 3.5 Comprehensions
# ---------------------------------------------------------------------------

# TODO: use a for comprehension to produce a multiplication table

# ---------------------------------------------------------------------------
# 3.6 Recursion
# ---------------------------------------------------------------------------

defmodule MyList do
  # TODO: implement sum/1 recursively
  def sum([]), do: 0
  def sum([head | tail]), do: head + sum(tail)

  # TODO: implement a tail-recursive version of sum
  def sum_tail(list), do: sum_tail(list, 0)
  defp sum_tail([], acc), do: acc
  defp sum_tail([head | tail], acc), do: sum_tail(tail, acc + head)
end

IO.inspect(MyList.sum([1, 2, 3, 4, 5]))
IO.inspect(MyList.sum_tail([1, 2, 3, 4, 5]))
