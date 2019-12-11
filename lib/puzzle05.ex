defmodule Puzzle05 do
  @moduledoc false

  @input "3,225,1,225,6,6,1100,1,238,225,104,0,1001,210,88,224,101,-143,224,224,4,224,1002,223,8,223,101,3,224,224,1,223,224,223,101,42,92,224,101,-78,224,224,4,224,1002,223,8,223,1001,224,3,224,1,223,224,223,1101,73,10,225,1102,38,21,225,1102,62,32,225,1,218,61,224,1001,224,-132,224,4,224,102,8,223,223,1001,224,5,224,1,224,223,223,1102,19,36,225,102,79,65,224,101,-4898,224,224,4,224,102,8,223,223,101,4,224,224,1,224,223,223,1101,66,56,224,1001,224,-122,224,4,224,102,8,223,223,1001,224,2,224,1,224,223,223,1002,58,82,224,101,-820,224,224,4,224,1002,223,8,223,101,3,224,224,1,223,224,223,2,206,214,224,1001,224,-648,224,4,224,102,8,223,223,101,3,224,224,1,223,224,223,1102,76,56,224,1001,224,-4256,224,4,224,102,8,223,223,1001,224,6,224,1,223,224,223,1102,37,8,225,1101,82,55,225,1102,76,81,225,1101,10,94,225,4,223,99,0,0,0,677,0,0,0,0,0,0,0,0,0,0,0,1105,0,99999,1105,227,247,1105,1,99999,1005,227,99999,1005,0,256,1105,1,99999,1106,227,99999,1106,0,265,1105,1,99999,1006,0,99999,1006,227,274,1105,1,99999,1105,1,280,1105,1,99999,1,225,225,225,1101,294,0,0,105,1,0,1105,1,99999,1106,0,300,1105,1,99999,1,225,225,225,1101,314,0,0,106,0,0,1105,1,99999,8,226,677,224,102,2,223,223,1005,224,329,101,1,223,223,1008,677,677,224,1002,223,2,223,1006,224,344,1001,223,1,223,107,226,677,224,102,2,223,223,1005,224,359,1001,223,1,223,1108,677,677,224,1002,223,2,223,1006,224,374,101,1,223,223,1107,677,677,224,1002,223,2,223,1006,224,389,101,1,223,223,108,226,677,224,102,2,223,223,1006,224,404,101,1,223,223,7,677,677,224,102,2,223,223,1006,224,419,101,1,223,223,108,677,677,224,102,2,223,223,1006,224,434,1001,223,1,223,7,226,677,224,102,2,223,223,1006,224,449,1001,223,1,223,108,226,226,224,102,2,223,223,1005,224,464,101,1,223,223,8,226,226,224,1002,223,2,223,1006,224,479,101,1,223,223,1008,226,226,224,102,2,223,223,1005,224,494,1001,223,1,223,1008,677,226,224,1002,223,2,223,1005,224,509,101,1,223,223,7,677,226,224,102,2,223,223,1006,224,524,101,1,223,223,1007,677,226,224,1002,223,2,223,1006,224,539,1001,223,1,223,1108,677,226,224,102,2,223,223,1005,224,554,1001,223,1,223,8,677,226,224,1002,223,2,223,1005,224,569,101,1,223,223,1108,226,677,224,1002,223,2,223,1005,224,584,101,1,223,223,1107,677,226,224,102,2,223,223,1006,224,599,101,1,223,223,107,226,226,224,102,2,223,223,1006,224,614,1001,223,1,223,107,677,677,224,1002,223,2,223,1005,224,629,1001,223,1,223,1107,226,677,224,1002,223,2,223,1006,224,644,101,1,223,223,1007,677,677,224,102,2,223,223,1006,224,659,1001,223,1,223,1007,226,226,224,1002,223,2,223,1006,224,674,1001,223,1,223,4,223,99,226"

  def input(puzzle) do
    puzzle
    |> String.split(",")
    |> Enum.map(&Integer.parse/1)
    |> Enum.map(fn {n, _} -> n end)
  end

  def input() do
    input(@input)
  end

  def replace_rest(rest, index, value) when index >= 0 do
    List.replace_at(rest, index, value)
  end

  def replace_rest(rest, _index, _value) do
    rest
  end

  def split_opcode(intcodeprogram, initial_value) do
    split_opcode(intcodeprogram, intcodeprogram, initial_value, 0)
  end

  def split_opcode(intcodeprogram, [3, pos|rest], current_value, count) do
    count = count + 2
    intcodeprogram
    |> List.replace_at(pos, current_value)
    |> split_opcode(replace_rest(rest, pos - count, current_value), current_value, count)
  end

  def split_opcode(intcodeprogram, [param_mode, pos|rest], _current_value, count) when rem(param_mode, 100) == 4 do
    count = count + 2
    current_value = case param_mode do
      4 -> Enum.at(intcodeprogram, pos)
      104 -> pos
    end
    IO.puts(current_value)
    split_opcode(intcodeprogram, rest, current_value, count)
  end

  def split_opcode(intcodeprogram, [param_mode, n1, n2, pos|rest], _current_value, count) when rem(param_mode, 100) == 1 do
    calc = case param_mode do
         1 -> Enum.at(intcodeprogram, n1) + Enum.at(intcodeprogram, n2)
       101 -> n1 + Enum.at(intcodeprogram, n2)
      1001 -> Enum.at(intcodeprogram, n1) + n2
      1101 -> n1 + n2
    end
    count = count + 4
    intcodeprogram
    |> List.replace_at(pos, calc)
    |> split_opcode(replace_rest(rest, pos - count, calc), calc, count)
  end

  def split_opcode(intcodeprogram, [param_mode, n1, n2, pos|rest], _current_value, count) when rem(param_mode, 100) == 2 do
    calc = case param_mode do
         2 -> Enum.at(intcodeprogram, n1) * Enum.at(intcodeprogram, n2)
       102 -> n1 * Enum.at(intcodeprogram, n2)
      1002 -> Enum.at(intcodeprogram, n1) * n2
      1102 -> n1 * n2
    end
    count = count + 4
    intcodeprogram
    |> List.replace_at(pos, calc)
    |> split_opcode(replace_rest(rest, pos - count, calc), calc, count)
  end

  def split_opcode(intcodeprogram, [param_mode, n1, n2|rest], current_value, count) when rem(param_mode, 100) == 5 do
    move = case param_mode do
      5 ->
        case Enum.at(intcodeprogram, n1) != 0 do
          true -> Enum.at(intcodeprogram, n2)
          _ -> count
        end
      105 ->
        case n1 != 0 do
          true -> Enum.at(intcodeprogram, n2)
          _ -> count
        end
      1005 ->
        case Enum.at(intcodeprogram, n1) != 0 do
          true -> n2
          _ -> count
        end
      1105 ->
        case n1 != 0 do
          true -> n2
          _ -> count
        end
    end
    case move do
      ^count ->
        count = count + 3
        intcodeprogram
        |> split_opcode(rest, current_value, count)
      _ ->
        intcodeprogram
        |> split_opcode(Enum.drop(intcodeprogram, move), current_value, move)
    end
  end

  def split_opcode(intcodeprogram, [param_mode, n1, n2|rest], current_value, count) when rem(param_mode, 100) == 6 do
    move = case param_mode do
      6 ->
        case Enum.at(intcodeprogram, n1) == 0 do
          true -> Enum.at(intcodeprogram, n2)
          _ -> count
        end
      106 ->
        case n1 == 0 do
          true -> Enum.at(intcodeprogram, n2)
          _ -> count
        end
      1006 ->
        case Enum.at(intcodeprogram, n1) == 0 do
          true -> n2
          _ -> count
        end
      1106 ->
        case n1 == 0 do
          true -> n2
          _ -> count
        end
    end
    case move do
      ^count ->
        count = count + 3
        intcodeprogram
        |> split_opcode(rest, current_value, count)
      _ ->
        intcodeprogram
        |> split_opcode(Enum.drop(intcodeprogram, move), current_value, move)
    end
  end

  def split_opcode(intcodeprogram, [param_mode, n1, n2, pos|rest], _current_value, count) when rem(param_mode, 100) == 7 do
    calc = case param_mode do
      7 -> Enum.at(intcodeprogram, n1) < Enum.at(intcodeprogram, n2)
      107 -> n1 < Enum.at(intcodeprogram, n2)
      1007 -> Enum.at(intcodeprogram, n1) < n2
      1107 -> n1 < n2
    end
    flag = if calc, do: 1, else: 0
    count = count + 4
    intcodeprogram
    |> List.replace_at(pos, flag)
    |> split_opcode(replace_rest(rest, pos - count, flag), flag, count)
  end

  def split_opcode(intcodeprogram, [param_mode, n1, n2, pos|rest], _current_value, count) when rem(param_mode, 100) == 8 do
    calc = case param_mode do
      8 -> Enum.at(intcodeprogram, n1) == Enum.at(intcodeprogram, n2)
      108 -> n1 == Enum.at(intcodeprogram, n2)
      1008 -> Enum.at(intcodeprogram, n1) == n2
      1108 -> n1 == n2
    end
    flag = if calc, do: 1, else: 0
    count = count + 4
    intcodeprogram
    |> List.replace_at(pos, flag)
    |> split_opcode(replace_rest(rest, pos - count, flag), flag, count)
  end

  def split_opcode(_intcodeprogram, [99|_rest], current_value, _count) do
    current_value
  end

  def part1() do
    input()
    |> split_opcode(1)
  end

  def part2() do
    input()
    |> split_opcode(5)
  end


end
