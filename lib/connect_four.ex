defmodule ConnectFour do
  @moduledoc """
  Connect four game
  """
  alias ConnectFour.Helpers

 def move(board, piece, column_index) do 
  List.update_at(board, column_index, fn column ->
      [piece | column] 
  end)
 end

 def check_vertically_adjacent(board, column_index) do
  board
  |> Enum.at(column_index)
  |> Helpers.is_four_in_succession?()
 end

 def check_horizontally_adjacent(board, column_index, direction) do
  board
  |> Helpers.horizonally_adjacent_pieces(column_index, direction, [])
  |> Helpers.is_four_in_succession?()
 end

 def check_diagonals(board, column_index) do
   move_piece_index =
    board
    |> Enum.at(column_index)
    |> Enum.count()
    |> div(-1)

   check_diagonal_to_bottom_left(board, column_index, move_piece_index)
 end

 def check_diagonal_to_bottom_left(board, column_index, current_piece_index) do
  pieces = Helpers.diagonally_adjacent_pieces(board, column_index, -1, +1, current_piece_index, [])
  case Helpers.is_four_in_succession?(pieces) do
    :no_winner -> 
      check_diagonal_to_top_right(board, column_index, current_piece_index)
    winner -> 
      winner
  end
 end

 def check_diagonal_to_top_right(board, column_index, current_piece_index) do
  pieces = Helpers.diagonally_adjacent_pieces(board, column_index, +1, -1, current_piece_index, [])
  case Helpers.is_four_in_succession?(pieces) do
    :no_winner -> 
      check_diagonal_to_top_left(board, column_index, current_piece_index)
    winner -> 
      winner
  end
 end

 def check_diagonal_to_top_left(board, column_index, current_piece_index) do 
  pieces = Helpers.diagonally_adjacent_pieces(board, column_index, -1, -1, current_piece_index, [])
  case Helpers.is_four_in_succession?(pieces) do
    :no_winner -> 
      check_diagonal_to_bottom_right(board, column_index, current_piece_index)
    winner -> 
      winner
  end
 end

 def check_diagonal_to_bottom_right(board, column_index, current_piece_index) do 
  board
  |> Helpers.diagonally_adjacent_pieces(column_index, +1, +1, current_piece_index, [])
  |> Helpers.is_four_in_succession?()
 end
end