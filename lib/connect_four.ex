defmodule ConnectFour do
  @moduledoc """
  Connect four game
  """
 def move(board, piece, column_index) do 
  List.update_at(board, column_index, fn column ->
      [piece | column] 
  end)
 end

 def winning_move?(board, column_index) do
  case check_stacked(board, column_index) do
    {:winner, nil} -> check_row_left(board, column_index)
    winner -> winner
  end
 end

 def check_stacked(board, column_index) do
  board
  |> Enum.at(column_index)
  |> is_four_in_succession?()
 end

 def check_row_left(board, column_index) do
  row_from_columns = generate_row_from_columns(board, column_index, -1, [])
  is_four_in_succession?(row_from_columns)
  case is_four_in_succession?(row_from_columns) do
    {:winner, nil} -> check_row_right(board, column_index)
    winner -> winner
  end
 end

 # TODO: Check diagonals from here
 def check_row_right(board, column_index) do
   row_from_columns = generate_row_from_columns(board, column_index, + 1, [])
   is_four_in_succession?(row_from_columns)
 end

 defp generate_row_from_columns(_, _, _, acc) when length(acc) == 4, do: acc 
 defp generate_row_from_columns(board, current_column_index, shift, acc) do
   current_column = Enum.at(board, current_column_index)
   piece = Enum.at(current_column, 0)
   next_column_index = current_column_index + shift
   generate_row_from_columns(board, next_column_index, shift, [piece | acc])
 end

 def check_diagonal_to_bottom_left(board, column_index) do
  current_column = Enum.at(board, column_index)
  current_piece_index = div(Enum.count(current_column), -1)
  row = generate_row_from_columns_diagonally(board, column_index, -1, +1, current_piece_index, [])
  is_four_in_succession?(row)
 end

 def check_diagonal_to_top_right(board, column_index) do
  current_column = Enum.at(board, column_index)
  current_piece_index = div(Enum.count(current_column), -1)
  row = generate_row_from_columns_diagonally(board, column_index, +1, -1, current_piece_index, [])
  is_four_in_succession?(row)
 end

 defp generate_row_from_columns_diagonally(_, _, _, _, _, acc) when length(acc) == 4, do: acc
 defp generate_row_from_columns_diagonally(board, column_index, column_shift, piece_shift, current_piece_index, acc) do
  current_column = Enum.at(board, column_index)
  piece = Enum.at(current_column, current_piece_index)
  next_column_index = column_index + column_shift
  next_piece_index = current_piece_index + piece_shift
  generate_row_from_columns_diagonally(board, next_column_index, column_shift, piece_shift, next_piece_index, [piece | acc])
 end

 defp is_four_in_succession?([p, p, p, p]) when not is_nil(p), do: {:winner, p}
 defp is_four_in_succession?(_), do: {:winner, nil}
end