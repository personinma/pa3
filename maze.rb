# Author: Steven Hu
# Maze class for PA03. Breaks a maze string out into a 
# maze of n * m size. Maze can check for solution from a
# starting (x,y) coordinate to an ending (x,y) coordinate

require_relative 'node'

class Maze

	attr_reader :maze

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

	# displays the original maze
	def display_original
		load(@maze_original)
		display
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
				temp << node
			end
		end
		return false
	end

	# given a (x,y) coordinate, it returns an array of surrounding Nodes
	# if the value of that surrounding Node is 0 and the parent of Node
	# (x,y) isn't that surrounding Node
	def get_neighbors(x, y)
		temp = []
		if @maze[[x+1,y]].value == 0 && @maze[[x,y]].parent != [x+1,y]
			@maze[[x+1,y]].parent = [x,y]
			temp << @maze[[x+1,y]]
		end
		if @maze[[x,y+1]].value == 0 && @maze[[x,y]].parent != [x,y+1]
			@maze[[x,y+1]].parent = [x,y]
			temp << @maze[[x,y+1]]
		end
		if @maze[[x-1,y]].value == 0 && @maze[[x,y]].parent != [x-1,y]
			@maze[[x-1,y]].parent = [x,y]
			temp << @maze[[x-1,y]]
		end
		if @maze[[x,y-1]].value == 0 && @maze[[x,y]].parent != [x,y-1]
			@maze[[x,y-1]].parent = [x,y]
			temp << @maze[[x,y-1]]
		end
		return temp
	end

	# displays the solved maze of given beginning and end (x,y) coordinates
	def trace(begX, begY, endX, endY)
		@maze.clear
		load(@maze_original)
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
				curr_x = @maze[[curr_x, curr_y]].parent[0]
				curr_y = @maze[[curr_x, curr_y]].parent[1]
				@maze[[curr_x, curr_y]].value = "X"
			end
		end
	end

	def redesign
		# still working on this
	end
end