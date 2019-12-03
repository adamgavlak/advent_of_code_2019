defmodule AdventOfCode.DayThree do

  def parse_input(input) do
    String.split(input, "\n")
  end

  def parse_instructions(instructions) do
    instructions
    |> String.split(",")
    |> Stream.map(&String.split_at(&1, 1))
    |> Enum.map(fn {op, len} -> {op, String.to_integer(len)} end)
  end

  def list_positions(instructions, positions \\ [], last_position \\ {0, 0})
  def list_positions([{direction, distance} | rest], positions, last_position) do
      new_positions =
        Enum.map(0..distance, fn d ->
          case direction do
            "U" -> {elem(last_position, 0), elem(last_position, 1) + d}
            "R" -> {elem(last_position, 0) + d, elem(last_position, 1)}
            "D" -> {elem(last_position, 0), elem(last_position, 1) - d}
            "L" -> {elem(last_position, 0) - d, elem(last_position, 1)}
          end
        end)

      list_positions(rest, positions ++ new_positions, List.last(new_positions))
  end

  def list_positions([], positions, _last_position), do: Enum.uniq(positions)

  def list_crossings(inputs) when is_list(inputs) do
    inputs
    |> Stream.map(&parse_instructions/1)
    |> Stream.map(&list_positions/1)
    |> Enum.reduce(Map.new(), fn positions, store ->
      Enum.reduce(positions, store, fn position, acc ->
        if Map.has_key?(acc, position) do
          Map.put(acc, position, Map.get(acc, position) + 1)
        else
          Map.put(acc, position, 1)
        end
      end)
    end)
    |> Enum.filter(fn
      {{0, 0}, _} -> false
      {position, count} -> count > 1
    end)
    |> Enum.map(fn {{x, y}, _count} -> {abs(x), abs(y)} end)
  end

  def nearest_crossing_distance(crossings) do
    crossings
    |> Enum.map(fn {x, y} -> x + y end)
    |> Enum.min()
  end

  def run() do
    File.read!("./lib/day_three/input")
    |> parse_input()
    |> list_crossings()
    |> nearest_crossing_distance()
  end
end