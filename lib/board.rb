# frozen_string_literal: true

require './lib/node'

# a
class Board
  def initialize(start_pos = [4, 3], goal = [0, 0])
    @board = Array.new(8) { Array.new(8, '_') }
    @start_pos = start_pos
    @cur_pos = start_pos
    @root = build_tree
  end

  def build_tree(board = @board)
    p @start_pos
    place_start
    show_board
    node = Node.new(@start_pos)
    possible_moves.each { |pos| node.children << Node.new(pos) unless pos[0].nil? && pos[1].nil? }
    node
  end

  def show_board
    p '######################################'
    @board.each { |row| p row}
  end

  def place_start(start_pos = @start_pos)
    @board[start_pos[0]][start_pos[1]] = '♞'
  end

  def possible_moves
    [
      move_2down_1left, move_2down_1right,
      move_2up_1left, move_2up_1right,
      move_2left_1down, move_2left_1up,
      move_2right_1down, move_2right_1up
  ]
  end

  def update_cur_pos(next_move)
    @cur_pos = next_move
  end

  def valid_move?(move)
    move[0].between?(0, 7) && move[1].between?(0, 7)
  end

  def move_2up_1left
    next_pos = [@cur_pos[0] - 2, @cur_pos[1] - 1]
    return next_pos if valid_move? next_pos
  end

  def move_2up_1right
    next_pos = [@cur_pos[0] - 2, @cur_pos[1] + 1]
    return next_pos if valid_move? next_pos
  end

  def move_2left_1down
    next_pos = [@cur_pos[0] + 1, @cur_pos[1] - 2]
    return next_pos if valid_move? next_pos
  end

  def move_2left_1up
    next_pos = [@cur_pos[0] - 1, @cur_pos[1] - 2]
    return next_pos if valid_move? next_pos
  end

  def move_2down_1left
    next_pos = [@cur_pos[0] + 2, @cur_pos[1] - 1]
    return next_pos if valid_move? next_pos
  end

  def move_2down_1right
    next_pos = [@cur_pos[0] + 2, @cur_pos[1] + 1]
    return next_pos if valid_move? next_pos
  end

  def move_2right_1up
    next_pos = [@cur_pos[0] - 1, @cur_pos[1] + 2]
    return next_pos if valid_move? next_pos
  end

  def move_2right_1down
    next_pos = [@cur_pos[0] + 1, @cur_pos[1] + 2]
    return next_pos if valid_move? next_pos
  end
end
