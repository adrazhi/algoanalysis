require 'matrix'
require './graph.rb'

## links for Fleury's algorithm
# http://www.ctl.ua.edu/math103/euler/ifagraph.htm
# http://www.it.brighton.ac.uk/staff/jt40/mm322/MM322_FleurysAlgorithm.pdf

class Fleury
	
	# things to consider:
	# all even vertices
	# what is a bridge


	def initialize(g="")
		if g == ""
			# random graph
			#@graph = Graph.new(7)

			# Below Graph in diagram http://i.imgur.com/sV1UzUn.png
			@graph = Matrix[ [0,1,1,0,0,1,1], # A
			    [1,0,0,0,0,0,0], # B
			    [1,0,0,0,0,0,0], # C
			    [0,0,0,0,1,1,0], # D
			    [0,0,0,1,0,1,1], # E
			    [1,0,0,1,1,0,0], # F
			    [1,0,0,0,1,0,0]  # G
			]
		else
			@graph = g
		end

		@LABELS = %w(A B C D E F G)

		@primitive_ops = 0
	end

	# check if edge between start and end is a bridge
	# return true/false
	def bridge(start,ending)
		@found = false
		graphtemp=@graph.to_a
		graphtemp[start][ending] = 0
		graphtemp[ending][start] = 0

		dfs(start,find = @LABELS[ending],graphtemp)
		return !@found		
	end

	# main method
	# return true/false
	# need to consider even/odd vertices
	def circuit

		visited = Array.new
		
		#start node
		start = (0..@graph.row_size-1).to_a.sample
		
		visited << start
		@primitive_ops += 1
		for i in 1..@graph.row_size
			# find unvisited neighbors
			neighbors = @graph.row(start).map.with_index{|x, i| i if x == 1 && !(visited.include? i)}.to_a.compact

			# stop
			if neighbors.length == 0
				break
			end

			# choose a neighbor randomly
			nextNode = neighbors.sample
			neighbors.delete(nextNode)

			#DEBUGGING: puts nextNode.to_s + ":" + neighbors.to_s + "(" + visited.to_s + ")" + "start" + start.to_s

			# check if bridge
			# if there is, pick a new neighbor
			if nextNode != nil
				while bridge(start,nextNode)
					if neighbors.length > 1
						neighbors.delete(nextNode)
						nextNode = neighbors.sample
					else
						break
					end
				end

				# add to visited and set new start
				visited << nextNode
				start = nextNode
				@primitive_ops += 1
			end
		end

		puts visited.to_s
		return visited

	end


		

	# Sourced: https://gist.github.com/gosuri/5126638
	# Depth-first search (DFS) is an algorithm for traversing or
	# searching a tree, tree structure, or graph. One starts at 
	# the root (selecting some node as the root in the graph case)
	# and explores as far as possible along each branch before backtracking.

	# vertex is vertex we're starting at
	# find is the vertex we're trying to get to
 
	def dfs(vertex,find="",graph)
	  # mark v as explored
	  #print "#{@LABELS[vertex]} " # visited

	  # nullify the row to mark the
	  # vertex as visited
	  edge = 0
	  while edge < graph.size
	  	@primitive_ops += 1
	    graph[vertex][edge] = 0
	    edge += 1
	  end

	  # check if its the vertex we're looking for
	  if (@LABELS[vertex] == find)
	  	@primitive_ops += 1
	    #print "found"
	    @found = true
	  end
	 
	  # Find unexplored edges
	  edge = 0
	  while edge < graph.size && !@found
	    # not explored and not same vertex
	    if ( graph[edge][vertex] != 0 && edge != vertex)
	      dfs(edge,find, graph)
	    end
	    edge += 1
	  end

	end

	# primitive ops are counted as follows:
	# if added to circuit, one operation.
	# for every edge comparison in DSF
	# if vertex is found, one operation.
	def primitive_ops
		puts "counted:"+@primitive_ops.to_s
	end

end

f = Fleury.new
f.circuit
f.primitive_ops
