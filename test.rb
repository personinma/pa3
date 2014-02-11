# Author: Steven Hu
# Maze test class

require_relative 'maze'

class Test

	test = Maze.new(4,4)
	test.load("111111111100010001111010101100010101101110101100000101111011101100000101111111111")
	test.display
	
	puts "Solving for starting coordinate (1,0) and ending coordinate (3,3):"
	result = test.solve(0,1,3,3)
	puts "Is there a solution? (True or False): #{result}"
	puts ""
	
	test.trace(1,0,3,3)
end