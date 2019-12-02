defmodule AdventOfCode.DayTwoTest do
  use ExUnit.Case

  alias AdventOfCode.DayTwo

  describe "puzzle 1" do
    test "For a mass of 12, divide by 3 and round down to get 4, then subtract 2 to get 2" do
      assert DayTwo.restore_program("1,9,10,3,2,3,11,0,99,30,40,50") == 3500
    end

    test "1,0,0,0,99 becomes 2,0,0,0,99 (1 + 1 = 2)" do
      assert DayTwo.restore_program("1,0,0,0,99") == 2
    end
  end
end