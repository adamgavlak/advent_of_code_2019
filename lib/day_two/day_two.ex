defmodule AdventOfCode.DayTwo do

  def restore_program(program, offset \\ 0)
  def restore_program(program, offset) when is_binary(program) do
    program
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> restore_program(offset)
  end

  def restore_program(program, offset) when is_list(program) do
    opcode = Enum.at(program, offset * 4)

    if opcode == 99 do
      List.first(program)
    else
      first_op_position = Enum.at(program, (offset * 4) + 1)
      second_op_position = Enum.at(program, (offset * 4) + 2)
      destination = Enum.at(program, (offset * 4) + 3)
      first_op = Enum.at(program, first_op_position)
      second_op = Enum.at(program, second_op_position)

      case opcode do
        1 ->
          program
          |> List.update_at(destination, fn _ -> first_op + second_op end)
          |> restore_program(offset + 1)

        2 ->
          program
          |> List.update_at(destination, fn _ -> first_op * second_op end)
          |> restore_program(offset + 1)
      end
    end
  end

  def run() do
    input = File.read!("./lib/day_two/input")

    input
    |> String.split(",")
    |> List.update_at(1, fn _ -> "12" end)
    |> List.update_at(2, fn _ -> "2" end)
    |> Enum.join(",")
    |> restore_program()
  end
end