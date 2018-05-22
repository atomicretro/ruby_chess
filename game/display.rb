require 'byebug'
require 'colorize'
require_relative 'cursor'
require_relative 'board'
require_relative '../pieces/chess_piece'

# RENDER IS TOO TIGHT
# MAKE PIECES BIGGER?



class Display

  attr_reader :cursor, :board, :b_val

  def initialize(board)

    @board = board
    @b_val = board.board
    @cursor = Cursor.new([0,0], board)
  end

  def render
    # render_board
    system "clear"
    print_arr = build_render
    render_cursor!(print_arr)
    make_pretty_array(print_arr)
  end

  def build_render
    print_arr = []

    0.upto(7) do |x|
      temp_arr = []

      0.upto(7) do |y|
        val = board_colorize(x,y)
        temp_arr << ["#{val} "]
      end

      print_arr << temp_arr
    end

    print_arr
  end

  def make_pretty_array(print_arr)
    print_arr.each do |row|
      # colorize is severly lacking in some respects.
      puts "#{row[0][0]}#{row[1][0]}#{row[2][0]}#{row[3][0]}#{row[4][0]}#{row[5][0]}#{row[6][0]}#{row[7][0]}"
    end
    puts "\nHELLO WORLD. GLORY TO HYPNOTOAD."
  end

  def render_cursor!(print_arr)
    cus_x, cus_y = cursor.cursor_pos
    print_arr_val = print_arr[cus_x][cus_y][0]

    print_arr[cus_x][cus_y][0] = print_arr_val.colorize(:black).on_cyan
  end

  def board_colorize(x,y)
    # byebug
    if (x.odd? && y.odd?) || (x.even? && y.even?)
      b_val[x][y].display.colorize(:black).on_light_blue
    else
      b_val[x][y].display.colorize(:white).on_light_red
    end
  end

end # class end

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  disp = Display.new(board)
  # disp.render
  # puts ""
  # move = [rand(8),rand(8)]
  disp.render
  input = disp.cursor.get_input
  until input == :crtl_c
    puts " "
    disp.render
    input = disp.cursor.get_input
  end

end
