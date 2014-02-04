# Author: Steven Hu

class Maze

	attr_accessor :maze

	def initialize(n, m)
		@cell_row = n
		@cell_col = m
		@wall_row = (n*2) + 1
		@wall_col = (m*2) + 1
		@maze = Hash.new
		@maze_string = ""
	end

	def load(arg)
		# will add a check to see if string is of valid form (wall_row * wall_col)
		counter = 0
		arg.split("").each do |i|
			@maze[[counter / @wall_row, counter % @wall_row]] = i.to_i
			counter += 1
		end
		@maze_string = args
	end

	def display
		display = @maze_string.chars.to_a
		# might refactor
		for x in 0..((@maze_string.length)-1)
			if x % wall_row
				put "#{display[x..(wall_row - 1)]}"
			end
		end
	end

	def solve(begX, begY, endX, endY)
		temp = []
		temp.push([(begX * 2) + 1,(begY * 2) + 1])
		while temp.length != 0
			pop = temp.pop
			if pop == [(endX * 2) + 1,(endY * 2) + 1]
				return true
			end
			neighbors = get_neighbors(pop[0],pop[1])
			if neighbors.length > 0
				neighbors.each do |x,y|
					temp.push([x,y])
				end
			end
		end
		return false
	end

	def get_neighbors(x, y)
		temp = []
		if @maze[x+1,y] == 0
			temp << [x+1,y]
		if @maze[x,y+1] == 0
			temp << [x,y+1]
		if @maze[x-1,y] == 0
			temp << [x-1,y]
		if @maze[x-1,y-1] == 0
			temp << [x-1,y-1]			
		return temp
	end

	def trace(begX, begY, endX, endY)
		# will think of something witty later
	end

	def redesign
		# if I get to it
	end

end

