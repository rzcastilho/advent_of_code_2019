defmodule Puzzle04 do
  @moduledoc false

  @input 264360..746325

  def filter_decreasing_sequences(number) do
    Integer.to_charlist(number)
    |> Enum.reduce_while({true, Integer.to_charlist(0) |> List.first},
        fn
          n, {return, last} when n >= last -> {:cont, {return, n}}
          n, _ -> {:halt, {false, n}}
         end
      )
    |> elem(0)
  end

  def filter_no_double_sequences(number) do
    Integer.to_charlist(number)
    |> Enum.reduce_while({false, Integer.to_charlist(0) |> List.first},
        fn
          n, {_, last} when n == last -> {:halt, {true, n}}
          n, _ -> {:cont, {false, n}}
        end
      )
    |> elem(0)
  end

  def filter_adjacent_matching_digits(number) do
    (
      Integer.to_charlist(number)
      |> Enum.reduce(%{},
          fn
            n, acc ->
              case Map.get(acc, n) do
                nil ->  Map.put(acc, n, 1)
                val -> Map.put(acc, n, val + 1)
              end
          end
        )
      |> Map.to_list
      |> Enum.filter(fn {_, count} -> count == 2 end)
      |> Enum.count
    ) > 0
  end

  def input() do
    @input
    |> Enum.filter(&filter_decreasing_sequences/1)
    |> Enum.filter(&filter_no_double_sequences/1)
  end

  def part1() do
    input()
    |> Enum.count()
  end

  def part2() do
    input()
    |> Enum.filter(&filter_adjacent_matching_digits/1)
    |> Enum.count()
  end

end
