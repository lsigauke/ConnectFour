defmodule ConnectFourTest do
  use ExUnit.Case
  doctest ConnectFour

  setup do 
    empty_board = [[],[],[],[],[],[],[],[],[]]
    {:ok, empty_board: empty_board}
  end

  test "make a move", %{empty_board: board} do
    updated_board = ConnectFour.move(board, :x, 0)
    assert updated_board == [[:x],[],[],[],[],[],[],[],[]]
  end
  
  test "connect 4 stacked wins", %{empty_board: board} do
    updated_board =  ConnectFour.move(board, :x, 0)
    assert {:winner, nil} == ConnectFour.check_stacked(updated_board, 0)

    updated_board =  ConnectFour.move(updated_board, :x, 0)
    assert {:winner, nil} == ConnectFour.check_stacked(updated_board, 0)

    updated_board =  ConnectFour.move(updated_board, :x, 0)
    assert {:winner, nil} == ConnectFour.check_stacked(updated_board, 0)

    updated_board =  ConnectFour.move(updated_board, :x, 0)
    assert {:winner, :x} == ConnectFour.check_stacked(updated_board, 0)
  end

  test "connect 4 at bottom going to the left wins", %{empty_board: board} do
    updated_board =  ConnectFour.move(board, :x, 0)
    assert {:winner, nil} == ConnectFour.check_row_left(updated_board, 0)

    updated_board =  ConnectFour.move(updated_board, :x, 1)
    assert {:winner, nil} == ConnectFour.check_row_left(updated_board, 1)

    updated_board =  ConnectFour.move(updated_board, :x, 2)
    assert {:winner, nil} == ConnectFour.check_row_left(updated_board, 2)

    updated_board =  ConnectFour.move(updated_board, :x, 3)
    assert {:winner, :x} == ConnectFour.check_row_left(updated_board, 3)
  end

  test "connect 4 going to the left at any level wins", %{empty_board: board} do
    updated_board =  ConnectFour.move(board, :x, 0)
    updated_board =  ConnectFour.move(updated_board, :x, 0)
    assert {:winner, nil} == ConnectFour.check_row_left(updated_board, 0)

    updated_board =  ConnectFour.move(updated_board, :x, 1)
    updated_board =  ConnectFour.move(updated_board, :x, 1)
    assert {:winner, nil} == ConnectFour.check_row_left(updated_board, 1)

    updated_board =  ConnectFour.move(updated_board, :x, 2)
    updated_board =  ConnectFour.move(updated_board, :x, 2)
    assert {:winner, nil} == ConnectFour.check_row_left(updated_board, 2)

    updated_board =  ConnectFour.move(updated_board, :y, 3)
    updated_board =  ConnectFour.move(updated_board, :x, 3)
    assert {:winner, :x} == ConnectFour.check_row_left(updated_board, 3)
  end

  test "connect 4 going to the right at bottom wins", %{empty_board: board} do
    updated_board =  ConnectFour.move(board, :x, 3)
    assert {:winner, nil} == ConnectFour.check_row_right(updated_board, 3)

    updated_board =  ConnectFour.move(updated_board, :x, 2)
    assert {:winner, nil} == ConnectFour.check_row_right(updated_board, 2)

    updated_board =  ConnectFour.move(updated_board, :x, 1)
    assert {:winner, nil} == ConnectFour.check_row_right(updated_board, 1)

    updated_board =  ConnectFour.move(updated_board, :x, 0)
    assert {:winner, :x} == ConnectFour.check_row_right(updated_board, 0)
  end 

  test "connect 4 going to the right at any level wins", %{empty_board: board} do
    updated_board =  ConnectFour.move(board, :x, 3)
    updated_board =  ConnectFour.move(updated_board, :x, 3)
    assert {:winner, nil} == ConnectFour.check_row_right(updated_board, 3)

    updated_board =  ConnectFour.move(updated_board, :x, 2)
    updated_board =  ConnectFour.move(updated_board, :x, 2)
    assert {:winner, nil} == ConnectFour.check_row_right(updated_board, 2)

    updated_board =  ConnectFour.move(updated_board, :x, 1)
    updated_board =  ConnectFour.move(updated_board, :x, 1)
    assert {:winner, nil} == ConnectFour.check_row_right(updated_board, 1)

    updated_board =  ConnectFour.move(updated_board, :y, 0)
    updated_board =  ConnectFour.move(updated_board, :x, 0)
    assert {:winner, :x} == ConnectFour.check_row_right(updated_board, 0)
  end
  
  test "connect 4 diagonally to bottom left wins", %{empty_board: board} do
    updated_board =  ConnectFour.move(board, :x, 0)
    
    assert {:winner, nil} == ConnectFour.check_diagonal_to_bottom_left(updated_board, 0)

    updated_board =  ConnectFour.move(updated_board, :y, 1)
    updated_board =  ConnectFour.move(updated_board, :x, 1)

    assert {:winner, nil} == ConnectFour.check_diagonal_to_bottom_left(updated_board, 1)

    updated_board =  ConnectFour.move(updated_board, :y, 2)
    updated_board =  ConnectFour.move(updated_board, :y, 2)
    updated_board =  ConnectFour.move(updated_board, :x, 2)

    assert {:winner, nil} == ConnectFour.check_diagonal_to_bottom_left(updated_board, 2)
    
    updated_board =  ConnectFour.move(updated_board, :x, 3)
    updated_board =  ConnectFour.move(updated_board, :x, 3)
    updated_board =  ConnectFour.move(updated_board, :y, 3)
    updated_board =  ConnectFour.move(updated_board, :x, 3)
    
    assert {:winner, :x} == ConnectFour.check_diagonal_to_bottom_left(updated_board, 3)
  end

  test "connect 4 diagonally to top right wins", %{empty_board: board} do
    updated_board =  ConnectFour.move(board, :x, 3)
    updated_board =  ConnectFour.move(updated_board, :x, 3)
    updated_board =  ConnectFour.move(updated_board, :y, 3)
    updated_board =  ConnectFour.move(updated_board, :x, 3)
    
    assert {:winner, nil} == ConnectFour.check_diagonal_to_top_right(updated_board, 3)
    
    updated_board =  ConnectFour.move(updated_board, :y, 2)
    updated_board =  ConnectFour.move(updated_board, :y, 2)
    updated_board =  ConnectFour.move(updated_board, :x, 2)

    assert {:winner, nil} == ConnectFour.check_diagonal_to_top_right(updated_board, 2)

    updated_board =  ConnectFour.move(updated_board, :y, 1)
    updated_board =  ConnectFour.move(updated_board, :x, 1)

    assert {:winner, nil} == ConnectFour.check_diagonal_to_top_right(updated_board, 1)

    updated_board =  ConnectFour.move(updated_board, :x, 0)
    assert {:winner, :x} == ConnectFour.check_diagonal_to_top_right(updated_board, 0)
  end
end
