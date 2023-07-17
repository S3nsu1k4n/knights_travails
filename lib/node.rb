# frozen_string_literal: true

# node for the tree
class Node
  attr_accessor :data, :children, :parent

  def initialize(data = nil, parent = nil, children = [])
    @data = data
    @parent = parent
    @children = children
  end

  def to_s
    string = "Node#{data}"
    string += " -> parent:#{@parent.data}" unless @parent.nil?
    string += ' -> children:'
    children.each do |node|
      string += "#{node.data}, "
    end
    string
  end
end
