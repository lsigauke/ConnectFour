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

 defp check_stacked(board, column_index) do
  board
  |> Enum.at(column_index)
  |> is_four_in_succession?()
 end

 defp check_row_left(board, column_index) do
  row_from_columns = generate_row_from_columns(board, column_index, -1, [])
  is_four_in_succession?(row_from_columns)
 end
 
 defp generate_row_from_columns(_, current_index, _, acc) when current_index < 0, do: acc 
 defp generate_row_from_columns(board, current_index, step_value, acc) do
   current_column = Enum.at(board, current_index)
   generate_row_from_columns(board, current_index + step_value, step_value, [hd(current_column) | acc])
 end

 defp is_four_in_succession?([p, p, p, p]) when not is_nil(p), do: {:winner, p}
 defp is_four_in_succession?(_), do: {:winner, nil}
end
