# frozen_string_literal: true

require './lib/board'

def knight_moves(start_pos, end_pos)
  board = Board.new(start_pos, end_pos)
  board.root
end

knight_moves([4, 3], [3, 3])
