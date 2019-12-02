defmodule Puzzle02 do
  @moduledoc false

  @input "1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,13,1,19,1,10,19,23,1,6,23,27,1,5,27,31,1,10,31,35,2,10,35,39,1,39,5,43,2,43,6,47,2,9,47,51,1,51,5,55,1,5,55,59,2,10,59,63,1,5,63,67,1,67,10,71,2,6,71,75,2,6,75,79,1,5,79,83,2,6,83,87,2,13,87,91,1,91,6,95,2,13,95,99,1,99,5,103,2,103,10,107,1,9,107,111,1,111,6,115,1,115,2,119,1,119,10,0,99,2,14,0,0"

  def input() do
    @input
    |> String.split(",")
    |> Enum.map(&Integer.parse/1)
    |> Enum.map(fn {n, _} -> n end)
  end

  def replace_rest(rest, index, value) when index >= 0 do
    List.replace_at(rest, index, value)
  end

  def replace_rest(rest, _index, _value) do
    rest
  end

  def split_opcode([zero, _, _|rest], noun, verb) when is_number(noun) and is_number(verb) do
    intcodeprogram = [zero, noun, verb] ++ rest
    split_opcode(intcodeprogram, intcodeprogram, 0)
  end

  def split_opcode(intcodeprogram, [1, n1, n2, pos|rest], count) do
    calc = Enum.at(intcodeprogram, n1) + Enum.at(intcodeprogram, n2)
    count = count + 4
    intcodeprogram
    |> List.replace_at(pos, calc)
    |> split_opcode(replace_rest(rest, pos - count, calc), count)
  end

  def split_opcode(intcodeprogram, [2, n1, n2, pos|rest], count) do
    calc = Enum.at(intcodeprogram, n1) * Enum.at(intcodeprogram, n2)
    count = count + 4
    intcodeprogram
    |> List.replace_at(pos, calc)
    |> split_opcode(replace_rest(rest, pos - count, calc), count)
  end

  def split_opcode([result|_], [99|_rest], _count) do
    result
  end

  def part1 do
    input()
    |> split_opcode(12, 2)
  end

  def part2 do
    0..99
    |> Enum.map(
         fn noun ->
           0..99
           |> Enum.map(fn verb -> {noun, verb} end)
         end
       )
    |> List.flatten
    |> Enum.find(fn {noun, verb} ->
                 case split_opcode(input(), noun, verb) do
                   19690720 -> true
                   _ -> false
                 end
               end)
    |> (fn {noun, verb} -> 100 * noun + verb end).()
  end

end
