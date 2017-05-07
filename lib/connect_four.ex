defmodule ConnectFour do
  @moduledoc """
  Connect four game
  """
  alias ConnectFour.Helpers
  
  def start do
    empty_board = [[],[],[],[],[],[],[]]
    state = {empty_board, 1}
    IO.puts("--------- Welcome to Connect 4! ---------")
    game_loop(state)
  end

  def game_loop({board, player_no}) do
    col = get_input(player_no)
    updated_board =
      board      
      |> Helpers.move(get_player_piece(player_no), col)
      |> Helpers.print()
    
    case check_winner_vertical(updated_board, col) do
      :no_winner ->
        game_loop({updated_board, switch_player(player_no)})
      winner -> 
        winner
    end
  end

  def get_input(player_no) do 
    col = IO.gets("\nPlayer #{player_no}, please enter column number (1-7) ")
        |> String.strip() 
        |> Integer.parse()
        |> validate_input()

    if (col == :invalid), do: get_input(player_no), else: col - 1
  end   

  def validate_input(:error), do: :invalid
  def validate_input({value, _rem}) when value > 7, do: :invalid
  def validate_input({value, _rem}) when value < 0 , do: :invalid
  def validate_input({value, _rem}), do: value

  defp check_winner_vertical(board, col) do
    case Helpers.check_vertically_adjacent(board, col) do
      :no_winner -> 
          check_winner_horizontal_left(board, col)
      winner -> 
          winner
    end
  end

  defp check_winner_horizontal_left(board, col) do
    case Helpers.check_horizontally_adjacent_left(board, col) do
      :no_winner ->
        check_winner_right(board, col)
      winner ->
        winner
    end
  end

  defp check_winner_right(board, col) do
    case Helpers.check_horizontally_adjacent_right(board, col) do
      :no_winner -> 
        move_piece_index = get_index_of_piece_in_column(board, col)
        check_winner_diagonally_bottom_right(board, col, move_piece_index)
      winner -> 
        winner
    end
  end
  
  defp get_index_of_piece_in_column(board, column_index) do
    board
    |> Enum.at(column_index)
    |> Enum.count()
    |> div(-1)
  end

  defp check_winner_diagonally_bottom_right(board, col, move_piece_index) do
    case Helpers.check_diagonal_to_bottom_right(board, col, move_piece_index) do
      :no_winner ->
        check_winner_diagonally_top_left(board, col, move_piece_index)
      winner ->
        winner
    end
  end

  defp check_winner_diagonally_top_left(board, col, move_piece_index) do
    case Helpers.check_diagonal_to_top_left(board, col, move_piece_index) do
      :no_winner ->
        check_winner_diagonally_bottom_left(board, col, move_piece_index)
      winner -> 
        winner
    end
  end

  defp check_winner_diagonally_bottom_left(board, col, move_piece_index) do
    case Helpers.check_diagonal_to_bottom_left(board, col, move_piece_index) do
      :no_winner -> 
        check_winner_diagonally_top_right(board, col, move_piece_index)
      winner -> 
        winner  
    end
  end

  defp check_winner_diagonally_top_right(board, col, move_piece_index) do
    case Helpers.check_diagonal_to_top_right(board, col, move_piece_index) do
      :no_winner -> 
        :no_winner
      winner -> 
        winner
    end
  end 

  defp switch_player(player_no) do
    if player_no == 1, do: 2, else: 1
  end

  defp get_player_piece(player_no) do
    if player_no == 1, do: :x, else: :y 
  end
end