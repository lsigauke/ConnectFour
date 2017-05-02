defmodule ConnectFour.Helpers do
  @moduledoc """
  Helpers for connect four game
  """
 def horizonally_adjacent_pieces(_, _, _, acc) when length(acc) == 4, do: acc 
 def horizonally_adjacent_pieces(board, current_column_index, shift, acc) do
   current_column = Enum.at(board, current_column_index)
   piece = Enum.at(current_column, 0)
   next_column_index = current_column_index + shift
   horizonally_adjacent_pieces(board, next_column_index, shift, [piece | acc])
 end

 def diagonally_adjacent_pieces(_, _, _, _, _, acc) when length(acc) == 4, do: acc
 def diagonally_adjacent_pieces(_, _, _, _, _, [_, item | _] = acc) when is_nil(item), do: acc
 def diagonally_adjacent_pieces(board, column_index, column_shift, piece_shift, current_piece_index, acc) do
  current_column = Enum.at(board, column_index)
  piece = Enum.at(current_column, current_piece_index)
  next_column_index = column_index + column_shift
  next_piece_index = current_piece_index + piece_shift
  diagonally_adjacent_pieces(board, next_column_index, column_shift, piece_shift, next_piece_index, [piece | acc])
 end

 def is_four_in_succession?([p, p, p, p]) when not is_nil(p), do: {:winner, p}
 def is_four_in_succession?(_), do: :no_winner
end