defmodule AdventOfCode.DayOne do
  # Puzzle 1
  def calculate_fuel(mass) do
    mass
    |> Kernel.div(3)
    |> Kernel.-(2)
  end

  # Puzzle 2
  def calculate_fuel_for_mass(mass, fuel \\ 0) do
    required_fuel = calculate_fuel(mass)

    if required_fuel > 0 do
      calculate_fuel_for_mass(required_fuel, fuel + required_fuel)
    else
      fuel
    end
  end

  def sum_of_all_modules(calc_fn) do
    File.read!("./lib/day_one/input")
    |> String.split("\n")
    |> Stream.map(&String.to_integer/1)
    |> Stream.map(&(Task.async(fn -> calc_fn.(&1) end)))
    |> Stream.map(&Task.await/1)
    |> Enum.sum()
  end
end