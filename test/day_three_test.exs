defmodule AdventOfCode.DayThreeTest do
  use ExUnit.Case

  alias AdventOfCode.DayThree

  describe "puzzle 1" do
    test "string" do
      assert [
        {"R", 8},
        {"U", 5},
        {"L", 5},
        {"D", 3}
      ] = DayThree.parse_instructions("R8,U5,L5,D3")
    end

    test "positions" do
      assert [
        {0, 0},
        {1, 0},
        {2, 0},
        {3, 0},
        {4, 0},
        {5, 0},
        {6, 0},
        {7, 0},
        {8, 0},
        {8, 1},
        {8, 2},
        {8, 3},
        {8, 4},
        {8, 5},
        {7, 5},
        {6, 5},
        {5, 5},
        {4, 5},
        {3, 5},
        {3, 4},
        {3, 3},
        {3, 2}
      ] = DayThree.parse_instructions("R8,U5,L5,D3") |> DayThree.list_positions()
    end

    test "two" do
      assert [{6, 5}, {3, 3}] = DayThree.list_crossings([
        "R8,U5,L5,D3",
        "U7,R6,D4,L4"
      ])
    end

    test "nearest crossing should be 6" do
      assert 6 ==
        "R8,U5,L5,D3\nU7,R6,D4,L4"
        |> DayThree.parse_input()
        |> DayThree.list_crossings()
        |> DayThree.nearest_crossing_distance()
    end

    test "nearest crossing should be 159" do
      assert 159 ==
        "R75,D30,R83,U83,L12,D49,R71,U7,L72\nU62,R66,U55,R34,D71,R55,D58,R83"
        |> DayThree.parse_input()
        |> DayThree.list_crossings()
        |> DayThree.nearest_crossing_distance()
    end

    test "nearest crossing should be 135" do
      assert 135 ==
        "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51\nU98,R91,D20,R16,D67,R40,U7,R15,U6,R7"
        |> DayThree.parse_input()
        |> DayThree.list_crossings()
        |> DayThree.nearest_crossing_distance()
    end
  end
end