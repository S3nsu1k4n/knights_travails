# frozen_string_literal: true

# node for the tree
class Node
  attr_accessor :data, :children

  def initialize(data = nil, children = [])
    @data = data
    @children = children
  end
end
