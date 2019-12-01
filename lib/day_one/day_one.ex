defmodule AdventOfCode.DayOne do
  def calculate_fuel(mass) do
    mass
    |> Kernel.div(3)
    |> Kernel.-(2)
  end

  def sum_of_all_modules() do
    File.read!("./lib/day_one/input")
    |> String.split("\n")
    |> Stream.map(&String.to_integer/1)
    |> Stream.map(&(Task.async(fn -> calculate_fuel(&1) end)))
    |> Enum.map(&Task.await/1)
    |> Enum.sum()
  end
end