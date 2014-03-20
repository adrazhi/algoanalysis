#Heirholzer's Algorithm

require 'matrix'

class Heirholzer
	#Heilhozer's algorithm for finding Eularian Cycle
	#Starting graph must have even degree of vertices
	#Params:
	#	adjacentList	-> Array of left adjacent vertices(edges)
	#	cycle			-> Array of vertices in Eularian cycle
	#Returns:
	#	Array of vertices in Eularian cycle, where each edge in the graph goes
	#	from one vertex to another
	def heir(adjacentList, cycle)
	
		vertex = nil #vertex used to iterate through cycle, etc
		adjacentList.each do |i,v|
			if(adjacentList[i].length > 0)
				if(cycle.empty? || cycle.include?(i))
					vertex = i
					break
				end
			end
		end

		if(vertex.nil?)
			return cycle 
		end
		
		subCycle = Array.new
		while(!vertex.nil?)
			subCycle.push(vertex)
			adjVertices = adjacentList[vertex]
			if(!adjVertices.nil? && adjVertices.length > 0)
				nextVert = adjVertices[0]
				#Delete edges
				if(adjacentList[vertex].include?(nextVert))
					adjacentList[vertex].delete(nextVert)
					adjacentList[nextVert].delete(vertex)
				end
				vertex = nextVert
			else
				vertex = nil
			end
		end
		
		#Merge all cycles
		if(cycle.empty?)
			cycle = subCycle
		else
			fullcycle = Array.new
			merged = false
			cycle.each do |i|
				fullcycle.push(i)
				if(i == subCycle[0] && !merged)
					for j in 1..subCycle.length
						fullcycle.push(subCycle[j])
						merged = true
					end
				end
			end
			cycle = fullcycle
		end
		
		return heir(adjacentList, cycle)
		
	end
	
	
	#Find the Eularian cycle using Heilhozer's algorithm
	#Graph must have even degree of vertices
	#Params:
	#	graph	-> adjacenty Matrix
	#Returns:
	#	Array of vertices in Eularian cycle, where each edge in the graph goes
	#	from one vertex to another
	def findCycle(graph)
		unusedEdges = Array.new
		adjacentList = Hash.new
		for i in 0..graph.row_count-1
			adjacentList[i] = Array.new
			for j in 0..graph.row_count-1
				if(graph.element(i,j) >= 1)
					adjacentList[i].push(j)
					unusedEdges.push([i,j])
				end
			end
		end
		
		#Abort if the degree of the vertices is odd
		adjacentList.each do |i|
			if(i.length % 2 != 0)
				abort("Not Eulerian")
			end
		end

		return heir(adjacentList, Array.new).compact #remove any nil values by compacting the array
		
	end

end

#Example
if __FILE__ == $0
	graph = Matrix[[0,1,1,1,1,0],[1,0,1,1,1,0],[1,1,0,0,1,1],[1,1,0,0,1,1],[1,1,1,1,0,0],[0,0,1,1,0,0]]

	example = Heirholzer.new
	value = example.findCycle(graph)

	af = "ABCDEFGH"
	value.each do |i|
		if(i.nil?)
			puts
		else
			puts af[i]
		end
	end
end

