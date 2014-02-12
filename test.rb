# Author: Steven Hu
# Maze test class

require_relative 'maze'

class Test

	test = Maze.new(4,4)
	test.load("111111111100010001111010101100010101101110101100000101111011101100000101111111111")
	puts "Original Maze:"
	test.display
	
	puts ""
	puts "Solving for starting coordinate (1,0) and ending coordinate (3,3):"
	result = test.solve(0,1,3,3)
	puts "Is there a solution? (True or False): #{result}"
	puts ""
	test.trace(1,0,3,3)

	puts ""
	puts "Solving for starting coordinate (3,3) and ending coordinate (0,0):"
	test.reset
	result = test.solve(3,3,0,0)
	puts "Is there a solution? (True or False): #{result}"
	puts ""
	test.trace(3,3,0,0)

	puts ""
	puts "Solving for starting coordinate (2,0) and ending coordinate (1,3):"
	test.reset
	result = test.solve(2,0,1,3)
	puts "Is there a solution? (True or False): #{result}"
	puts ""
	test.trace(2,0,1,3)
end