defmodule AdventOfCode.DayOneTest do
  use ExUnit.Case

  alias AdventOfCode.DayOne

  describe "puzzle 1" do
    test "For a mass of 12, divide by 3 and round down to get 4, then subtract 2 to get 2" do
      assert DayOne.calculate_fuel(12) == 2
    end

    test "For a mass of 14, dividing by 3 and rounding down still yields 4, so the fuel required is also 2" do
      assert DayOne.calculate_fuel(14) == 2
    end

    test "For a mass of 1969, the fuel required is 654" do
      assert DayOne.calculate_fuel(1969) == 654
    end

    test "For a mass of 100756, the fuel required is 33583" do
      assert DayOne.calculate_fuel(100756) == 33583
    end

    test "sum_of_all_modules returns correct fuel amount" do
      assert DayOne.sum_of_all_modules() == 3150224
    end
  end
end