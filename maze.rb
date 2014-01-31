# Author: Steven Hu

class Maze

	attr_accessor :maze

	def initialize(n, m)
		@cell_row = n
		@cell_col = m
		@wall_row = (n*2) + 1
		@wall_col = (m*2) + 1
		@maze = ""
	end

	def load(arg)
		# will add a check to see if string is of valid form (wall_row * wall_col)
		@maze = arg
	end

	def display
		display = @maze.chars.to_a
		# might refactor
		for x in 0..((@maze.length)-1)
			if x % wall_row
				put "#{display[x..(wall_row - 1)]}"
			end
		end
	end

	def solve
		# will be implementing with queues. probably going depth-first search approach.
	end

	def trace
		# most likely gonna have the work done in solve and trace will just be a printing 
		# method. will mark off the successful path with x's
	end

	def redesign
		# if I get to it
	end

end

