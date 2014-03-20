require 'matrix'


# A graph can be represented by its adjacency matrix G,
# where G[i][j] == 1 if there is an edge between 
# vertices i and j and 0 otherwise.
class Graph

	# creates square matrix n x n
	# randomly puts 0 or 1 for values
	def initialize(n)
		@m = Matrix.build(n) { rand(2) }
	end

	def get
		return @m
	end

end