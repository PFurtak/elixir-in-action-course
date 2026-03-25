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
