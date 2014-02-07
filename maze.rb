# Author: Steven Hu

class Maze
	attr_accessor :maze, :wall_row, :wall_col, :maze_string

	def initialize(n, m)
		@wall_row = (n*2) + 1
		@wall_col = (m*2) + 1
		@maze = Hash.new
		@maze_string = ""
		@solution = Hash.new
	end

	def load(arg)
		# will add a check to see if string is of valid form (wall_row * wall_col)
		counter = 0
		arg.split("").each do |i|
			@maze[[counter / @wall_row, counter % @wall_row]] = i.to_i
			counter += 1
		end
		@maze_string = arg
	end

	def display
		@maze.each do |key, val|
			if key[1] == (@wall_row - 1)
				puts val
			else
				print val
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
		if @maze[[x+1,y]] == 0
			temp << [x+1,y]
		end
		if @maze[[x,y+1]] == 0
			temp << [x,y+1]
		end
		if @maze[[x-1,y]] == 0
			temp << [x-1,y]
		end
		if @maze[[x-1,y-1]] == 0
			temp << [x-1,y-1]	
		end
		return temp
	end

	def trace(begX, begY, endX, endY)
		#@solution = @maze
	end

	def redesign
		# if I get to it
	end
end

test = Maze.new(4,4)
test.load("111111111100010001111010101100010101101110101100000101111011101100000101111111111")
test.display
puts test.solve(0,0,3,4)