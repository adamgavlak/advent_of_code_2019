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

  def run(input, noun \\ 12, verb \\ 2) do
    input
    |> String.split(",")
    |> List.update_at(1, fn _ -> to_string(noun) end)
    |> List.update_at(2, fn _ -> to_string(verb) end)
    |> Enum.join(",")
    |> restore_program()
  end

  def find_instructions do
    input = File.read!("./lib/day_two/input")

    {:ok, noun, verb} =
      Enum.flat_map(0..99, fn noun ->
        Enum.map(0..99, fn verb ->
          Task.async(fn ->
            case run(input, noun, verb) do
              19690720 -> {:ok, noun, verb}
              _ -> :error
            end
          end)
        end)
      end)
      |> Enum.map(&Task.await/1)
      |> Enum.find(fn
        {:ok, _noun, _verb} -> true
        _ -> false
      end)

    (100 * noun) + verb
  end
end