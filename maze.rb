# Author: Steven Hu
# Maze class for PA03. Breaks a maze string out into a 
# maze of n * m size. Maze can check for solution from a
# starting (x,y) coordinate to an ending (x,y) coordinate

require_relative 'node'

class Maze

	attr_reader :maze, :temp

	def initialize(n, m)
		@wall_row = (n*2) + 1
		@wall_col = (m*2) + 1
		@maze = Hash.new
		@maze_original = ""
	end

	# takes in a maze string and loads into @maze hash. also clones a copy of the original @maze hash
	# to @original
	def load(arg)
		@maze_original = arg
		counter = 0
		char_split = arg.split("")
		if char_split.length == @wall_row * @wall_col
			char_split.each do |i|
				x = counter % @wall_row
				y = counter / @wall_row
				@maze[[x, y]] = Node.new(i.to_i, x, y, nil)
				counter += 1
			end
			@original = @maze.clone
		else
			puts "Maze string is not of the correct form of #{(@wall_row-1)/2} x #{(@wall_col-1)/2}."
		end
	end

	# displays the maze in a viewable context for the user
	def display
		@maze.each do |key, val|
			if key[0] == (@wall_row - 1)
				puts val.value
			else
				print val.value
			end
		end
	end

	# resets the maze to original (the one from original load - @maze_original)
	def reset
		@maze.clear
		load(@maze_original)
	end

	# solves a maze by giving it a beginning and end (x,y) coordinates
	# solves it by using a breadth first seach algorithm (queue and while loop)
	def solve(begX, begY, endX, endY)
		temp = Array.new
		temp << @maze[[(begX * 2) + 1, (begY * 2) + 1]]
		while temp.length != 0
			current = temp.pop
			if current.x == ((endX * 2) + 1) && current.y == ((endY * 2) + 1)
				return true
			end
			neighbors = get_neighbors(current.x, current.y)
			neighbors.each do |node|
				if !node.nil?
					temp << node
				end
			end
		end
		return false
	end

	# given a (x,y) coordinate, it returns an array of surrounding Nodes
	# if the value of that surrounding Node is 0 and the parent of Node
	# (x,y) isn't that surrounding Node
	def get_neighbors(x, y)
		temp = []
		temp << neighbor_helper(x, y, 1, 0)
		temp << neighbor_helper(x, y, 0, 1)
		temp << neighbor_helper(x, y, -1, 0)
		temp << neighbor_helper(x, y, 0, -1)
		return temp
	end

	def neighbor_helper(x, y, a, b)
		if @maze[[x+a,y+b]].value == 0 && @maze[[x,y]].parent != [x+a,y+b]
			@maze[[x+a,y+b]].parent = [x,y]
			return @maze[[x+a, y+b]]
		end
		return nil
	end

	# displays the solved maze of given beginning and end (x,y) coordinates
	def trace(begX, begY, endX, endY)
		reset
		solve(begX, begY, endX, endY)
		curr_x = (endX * 2) + 1
		curr_y = (endY * 2) + 1
		return trace_helper(curr_x, curr_y)
	end

	# helper method for trace that marks S as the start, X as part of a path
	# and E as the end. returns the maze display after the changes
	def trace_helper(curr_x, curr_y)
		check = false
		@maze[[curr_x, curr_y]].value = "E"
		while check == false
			if @maze[[curr_x, curr_y]].parent.nil?
				@maze[[curr_x, curr_y]].value = "S"
				return display
			else
				par = @maze[[curr_x, curr_y]].parent
				curr_x = par[0]
				curr_y = par[1]
				@maze[[curr_x, curr_y]].value = "X"
			end
		end
	end

	def redesign
		# still working on this
	end
end