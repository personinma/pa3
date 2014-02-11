# Author: Steven Hu
# Node class that holds a maze cell's value, x/y coordinates, 
# and it's parent <- path's previous position

class Node

	attr_accessor :value, :x, :y, :parent

	def initialize(value, x, y, parent)
		@value = value
		@x = x
		@y = y
		@parent = parent
	end

end