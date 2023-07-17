# frozen_string_literal: true

require './lib/node'

# constracting the chess board as well as the tree and its search algorithm
class Board
  def initialize(start_pos = [4, 3], goal = [0, 0])
    @visited_nodes = []
    @board = Array.new(8) { Array.new(8, '_') }
    @start_pos = start_pos
    @cur_pos = start_pos
    @goal = goal
    @root = build_tree
  end

  def root
    puts @root
    p @goal
    p @root.data
    node = @root.parent
    until node.nil?
      p node.data
      node = node.parent
    end
  end

  def build_tree(node = Node.new(@start_pos), child_index = 0)
    return nil if child_index > 7
    possible_moves.each { |pos| node.children << Node.new(pos, node) unless pos.nil? || (!node.parent.nil? && pos == node.parent.data) }
    
    unless contains_goal? node
      if already_visited? node
        next_node = node.parent.children[child_index + 1]
        update_cur_pos next_node.data
        node = build_tree(next_node, child_index + 1)
      else
        @visited_nodes << (node.parent.nil? ? node.data : node.data + node.parent.data)
        next_node = node.children[child_index]
        update_cur_pos next_node.data
        node = build_tree(next_node, 0)
      end
    end
    node
  end

  def show_board
    p '######################################'
    @board.each { |row| p row}
  end

  def place_start(start_pos = @start_pos)
    @board[start_pos[0]][start_pos[1]] = '♞'
  end

  def already_visited?(node)
    return @visited_nodes.include? node.data + node.parent.data unless node.parent.nil?
    false
  end

  def contains_goal?(node)
    node.children.each do |child|
      return true if child.data == @goal
    end
    false
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
