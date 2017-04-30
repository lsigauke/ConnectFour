defmodule ConnectFourTest do
  use ExUnit.Case
  doctest ConnectFour

  setup do 
    empty_board = [[],[],[],[],[],[],[],[],[]]
    {:ok, empty_board: empty_board}
  end

  test "can make a move", %{empty_board: board} do
    updated_board = ConnectFour.move(board, :x, 0)
    assert updated_board == [[:x],[],[],[],[],[],[],[],[]]
  end
  
  test "only stacked four wins", %{empty_board: board} do
    updated_board =  ConnectFour.move(board, :x, 0)
    assert {:winner, nil} == ConnectFour.winning_move?(updated_board, 0)

    updated_board =  ConnectFour.move(updated_board, :x, 0)
    assert {:winner, nil} == ConnectFour.winning_move?(updated_board, 0)

    updated_board =  ConnectFour.move(updated_board, :x, 0)
    assert {:winner, nil} == ConnectFour.winning_move?(updated_board, 0)

    updated_board =  ConnectFour.move(updated_board, :x, 0)
    assert {:winner, :x} == ConnectFour.winning_move?(updated_board, 0)
  end

  test "only four in a row to the left wins at bottom", %{empty_board: board} do
    updated_board =  ConnectFour.move(board, :x, 0)
    assert {:winner, nil} == ConnectFour.winning_move?(updated_board, 0)

    updated_board =  ConnectFour.move(updated_board, :x, 1)
    assert {:winner, nil} == ConnectFour.winning_move?(updated_board, 1)

    updated_board =  ConnectFour.move(updated_board, :x, 2)
    assert {:winner, nil} == ConnectFour.winning_move?(updated_board, 2)

    updated_board =  ConnectFour.move(updated_board, :x, 3)
    assert {:winner, :x} == ConnectFour.winning_move?(updated_board, 3)
  end

  test "only four in a row to the left wins anywhere", %{empty_board: board} do
    updated_board =  ConnectFour.move(board, :x, 0)
    updated_board =  ConnectFour.move(updated_board, :x, 0)
    assert {:winner, nil} == ConnectFour.winning_move?(updated_board, 0)

    updated_board =  ConnectFour.move(updated_board, :x, 1)
    updated_board =  ConnectFour.move(updated_board, :x, 1)
    assert {:winner, nil} == ConnectFour.winning_move?(updated_board, 1)

    updated_board =  ConnectFour.move(updated_board, :x, 2)
    updated_board =  ConnectFour.move(updated_board, :x, 2)
    assert {:winner, nil} == ConnectFour.winning_move?(updated_board, 2)

    updated_board =  ConnectFour.move(updated_board, :y, 3)
    updated_board =  ConnectFour.move(updated_board, :x, 3)
    assert {:winner, :x} == ConnectFour.winning_move?(updated_board, 3)
  end 
end
