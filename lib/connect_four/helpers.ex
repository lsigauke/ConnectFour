  defmodule ConnectFour.Helpers do
  @moduledoc """
  Helpers for connect four game
  """
  def move(board, piece, column_index) do 
    List.update_at(board, column_index, fn column ->
      [piece | column] 
    end)
  end

  def check_vertically_adjacent(board, column_index) do
    board
    |> Enum.at(column_index)
    |> is_four_in_succession?()
  end

  def check_horizontally_adjacent_left(board, column_index) do
    board
    |> horizonally_adjacent_pieces(column_index, -1, [])
    |> is_four_in_succession?()
  end

  def check_horizontally_adjacent_right(board, column_index) do
    board
    |> horizonally_adjacent_pieces(column_index, +1, [])
    |> is_four_in_succession?()
  end

  def horizonally_adjacent_pieces(board, column_index, _, acc) when column_index == length(board), do: acc
  def horizonally_adjacent_pieces(_, _, _, acc) when length(acc) == 4, do: acc 
  def horizonally_adjacent_pieces(board, column_index, shift, acc) do
    piece =
      board
      |> Enum.at(column_index)
      |> Enum.at(0)
    
    next_column_index = column_index + shift
    horizonally_adjacent_pieces(board, next_column_index, shift, [piece | acc])
  end

  def check_diagonal_to_bottom_left(board, column_index, piece_index) do
    pieces = diagonally_adjacent_pieces(board, column_index, -1, +1, piece_index, [])
    is_four_in_succession?(pieces)
  end

  def check_diagonal_to_top_right(board, column_index, piece_index) do
    pieces = diagonally_adjacent_pieces(board, column_index, +1, -1, piece_index, [])
    is_four_in_succession?(pieces)
  end

  def check_diagonal_to_top_left(board, column_index, piece_index) do 
    pieces = diagonally_adjacent_pieces(board, column_index, -1, -1, piece_index, [])
    is_four_in_succession?(pieces)
  end

  def check_diagonal_to_bottom_right(board, column_index, piece_index) do 
    board
    |> diagonally_adjacent_pieces(column_index, +1, +1, piece_index, [])
    |> is_four_in_succession?()
  end  

  def diagonally_adjacent_pieces(board, column_index, _, _, _, acc) when column_index == length(board), do: acc
  def diagonally_adjacent_pieces(_, _, _, _, _, acc) when length(acc) == 4, do: acc
  def diagonally_adjacent_pieces(_, _, _, _, _, [_, item | _] = acc) when is_nil(item), do: acc
  def diagonally_adjacent_pieces(board, column_index, column_shift, piece_shift, piece_index, acc) do
   piece =
    board
    |> Enum.at(column_index)
    |> Enum.at(piece_index)

    next_column_index = column_index + column_shift
    next_piece_index = piece_index + piece_shift
    diagonally_adjacent_pieces(board, next_column_index, column_shift, piece_shift, next_piece_index, [piece | acc])
  end

  def is_four_in_succession?([p, p, p, p]) when not is_nil(p), do: {:winner, p}
  def is_four_in_succession?(_), do: :no_winner

  def print(board) do
    tallest_column = Enum.max_by(board, fn column -> 
      length(column)
    end)

    highest_index = length(tallest_column)
    print(board, div(highest_index, -1))
    board
  end  
  
  defp print(value, row_no) when not is_list(value) and is_nil(value) and row_no == 0 do
      IO.write("|   |")  
  end
  defp print(value, _row_no) when not is_list(value) and is_nil(value) do
     IO.write("   |")
  end
  defp print(value, row_no) when not is_list(value) and row_no == 0 do
     IO.write("| #{value} |")
  end
  defp print(value, row_no) when not is_list(value) and row_no != 0 do
    IO.write(" #{value} |")
  end
  defp print(board, row_no) when is_list(board) and row_no == 0 do
    IO.puts("| 1 | 2 | 3 | 4 | 5 | 6 | 7 |")
  end
  defp print(board, row_no) when is_list(board) do 
    Enum.scan(board, 0, fn column, column_index -> 
      value = Enum.at(column, row_no)
      print(value, column_index)
      column_index + 1
    end)
    IO.puts("\n")
    print(board, row_no + 1)
  end
end