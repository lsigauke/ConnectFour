defmodule ConnectFourTest do
  use ExUnit.Case
  doctest ConnectFour
  alias ConnectFour.Helpers

  setup do 
    empty_board = [[],[],[],[],[],[],[]]
    {:ok, empty_board: empty_board}
  end

  test "make a move", %{empty_board: board} do
    updated_board = Helpers.move(board, :x, 0)
    assert updated_board == [[:x],[],[],[],[],[],[]]
  end
  
  test "connect 4 stacked wins", %{empty_board: board} do
    updated_board = Helpers.move(board, :x, 0)
    assert :no_winner == Helpers.check_vertically_adjacent(updated_board, 0)

    updated_board = Helpers.move(updated_board, :x, 0)
    assert :no_winner == Helpers.check_vertically_adjacent(updated_board, 0)

    updated_board = Helpers.move(updated_board, :x, 0)
    assert :no_winner == Helpers.check_vertically_adjacent(updated_board, 0)

    updated_board = Helpers.move(updated_board, :x, 0)
    assert {:winner, :x} == Helpers.check_vertically_adjacent(updated_board, 0)
  end

  test "connect 4 at bottom going to the left wins", %{empty_board: board} do
    updated_board = Helpers.move(board, :x, 0)
    assert :no_winner == Helpers.check_horizontally_adjacent_left(updated_board, 0)

    updated_board = Helpers.move(updated_board, :x, 1)
    assert :no_winner == Helpers.check_horizontally_adjacent_left(updated_board, 1)

    updated_board = Helpers.move(updated_board, :x, 2)
    assert :no_winner == Helpers.check_horizontally_adjacent_left(updated_board, 2)

    updated_board = Helpers.move(updated_board, :x, 3)
    assert {:winner, :x} == Helpers.check_horizontally_adjacent_left(updated_board, 3)
  end

  test "connect 4 going to the left at any level wins", %{empty_board: board} do
    updated_board = Helpers.move(board, :x, 0)
    updated_board = Helpers.move(updated_board, :x, 0)
    assert :no_winner == Helpers.check_horizontally_adjacent_left(updated_board, 0)

    updated_board = Helpers.move(updated_board, :x, 1)
    updated_board = Helpers.move(updated_board, :x, 1)
    assert :no_winner == Helpers.check_horizontally_adjacent_left(updated_board, 1)

    updated_board = Helpers.move(updated_board, :x, 2)
    updated_board = Helpers.move(updated_board, :x, 2)
    assert :no_winner == Helpers.check_horizontally_adjacent_left(updated_board, 2)

    updated_board = Helpers.move(updated_board, :y, 3)
    updated_board = Helpers.move(updated_board, :x, 3)
    assert {:winner, :x} == Helpers.check_horizontally_adjacent_left(updated_board, 3)
  end

  test "connect 4 going to the right at bottom wins", %{empty_board: board} do
    updated_board = Helpers.move(board, :x, 3)
    assert :no_winner == Helpers.check_horizontally_adjacent_right(updated_board, 3)

    updated_board = Helpers.move(updated_board, :x, 2)
    assert :no_winner == Helpers.check_horizontally_adjacent_right(updated_board, 2)

    updated_board = Helpers.move(updated_board, :x, 1)
    assert :no_winner == Helpers.check_horizontally_adjacent_right(updated_board, 1)

    updated_board = Helpers.move(updated_board, :x, 0)
    assert {:winner, :x} == Helpers.check_horizontally_adjacent_right(updated_board, 0)
  end 

  test "connect 4 going to the right at any level wins", %{empty_board: board} do
    updated_board = Helpers.move(board, :x, 3)
    updated_board = Helpers.move(updated_board, :x, 3)
    assert :no_winner == Helpers.check_horizontally_adjacent_right(updated_board, 3)

    updated_board = Helpers.move(updated_board, :x, 2)
    updated_board = Helpers.move(updated_board, :x, 2)
    assert :no_winner == Helpers.check_horizontally_adjacent_right(updated_board, 2)

    updated_board = Helpers.move(updated_board, :x, 1)
    updated_board = Helpers.move(updated_board, :x, 1)
    assert :no_winner == Helpers.check_horizontally_adjacent_right(updated_board, 1)

    updated_board = Helpers.move(updated_board, :y, 0)
    updated_board = Helpers.move(updated_board, :x, 0)
    assert {:winner, :x} == Helpers.check_horizontally_adjacent_right(updated_board, 0)
  end
  
  test "connect 4 diagonally to bottom left wins", %{empty_board: board} do
    updated_board = Helpers.move(board, :x, 0)
    
    assert :no_winner == Helpers.check_diagonal_to_bottom_left(updated_board, 0, -1)

    updated_board = Helpers.move(updated_board, :y, 1)
    updated_board = Helpers.move(updated_board, :x, 1)

    assert :no_winner == Helpers.check_diagonal_to_bottom_left(updated_board, 1, -2)

    updated_board = Helpers.move(updated_board, :y, 2)
    updated_board = Helpers.move(updated_board, :y, 2)
    updated_board = Helpers.move(updated_board, :x, 2)

    assert :no_winner == Helpers.check_diagonal_to_bottom_left(updated_board, 2, -3)
    
    updated_board = Helpers.move(updated_board, :x, 3)
    updated_board = Helpers.move(updated_board, :x, 3)
    updated_board = Helpers.move(updated_board, :y, 3)
    updated_board = Helpers.move(updated_board, :x, 3)
    
    assert {:winner, :x} == Helpers.check_diagonal_to_bottom_left(updated_board, 3, -4)
  end

  test "connect 4 diagonally to top right wins", %{empty_board: board} do
    updated_board = Helpers.move(board, :x, 3)
    updated_board = Helpers.move(updated_board, :x, 3)
    updated_board = Helpers.move(updated_board, :y, 3)
    updated_board = Helpers.move(updated_board, :x, 3)
    
    assert :no_winner == Helpers.check_diagonal_to_top_right(updated_board, 3, -4)
    
    updated_board = Helpers.move(updated_board, :y, 2)
    updated_board = Helpers.move(updated_board, :y, 2)
    updated_board = Helpers.move(updated_board, :x, 2)

    assert :no_winner == Helpers.check_diagonal_to_top_right(updated_board, 2, -3)

    updated_board = Helpers.move(updated_board, :y, 1)
    updated_board = Helpers.move(updated_board, :x, 1)

    assert :no_winner == Helpers.check_diagonal_to_top_right(updated_board, 1, -2)

    updated_board = Helpers.move(updated_board, :x, 0)
    assert {:winner, :x} == Helpers.check_diagonal_to_top_right(updated_board, 0, -1)
  end

  test "connect 4 diagonally to top left wins", %{empty_board: board} do
    updated_board = Helpers.move(board, :x, 3)
    updated_board = Helpers.move(updated_board, :x, 3)
    updated_board = Helpers.move(updated_board, :y, 3)
    updated_board = Helpers.move(updated_board, :x, 3)
    
    assert :no_winner == Helpers.check_diagonal_to_top_left(updated_board, 3, -4)
    
    updated_board = Helpers.move(updated_board, :y, 4)
    updated_board = Helpers.move(updated_board, :y, 4)
    updated_board = Helpers.move(updated_board, :x, 4)

    assert :no_winner == Helpers.check_diagonal_to_top_left(updated_board, 4, -3)

    updated_board = Helpers.move(updated_board, :y, 5)
    updated_board = Helpers.move(updated_board, :x, 5)

    assert :no_winner == Helpers.check_diagonal_to_top_left(updated_board, 5, -2)

    updated_board = Helpers.move(updated_board, :x, 6)
    assert {:winner, :x} == Helpers.check_diagonal_to_top_left(updated_board, 6, -1)
  end

  test "connect 4 diagonally to bottom right wins", %{empty_board: board} do
    updated_board = Helpers.move(board, :x, 6)

    assert :no_winner == Helpers.check_diagonal_to_bottom_right(updated_board, 6, -1)

    updated_board = Helpers.move(updated_board, :y, 5)
    updated_board = Helpers.move(updated_board, :x, 5)

    assert :no_winner == Helpers.check_diagonal_to_bottom_right(updated_board, 5, -2)

    updated_board = Helpers.move(updated_board, :y, 4)
    updated_board = Helpers.move(updated_board, :y, 4)
    updated_board = Helpers.move(updated_board, :x, 4)

    assert :no_winner == Helpers.check_diagonal_to_bottom_right(updated_board, 4, -3)

    updated_board = Helpers.move(updated_board, :x, 3)
    updated_board = Helpers.move(updated_board, :x, 3)
    updated_board = Helpers.move(updated_board, :y, 3)
    updated_board = Helpers.move(updated_board, :x, 3)
    
    assert {:winner, :x} == Helpers.check_diagonal_to_bottom_right(updated_board, 3, -4)
  end
end