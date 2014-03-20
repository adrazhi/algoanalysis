require 'matrix'

#Quick fix to make changing a Matrix easier
class Matrix
  def []=(i, j, x)
    @rows[i][j] = x
  end
end

#Find Maximum Clique using  algorithm by Carraghan and Pardalos
class MaximumClique
	@savedVertices
	@max 					#current max clique size
	@maximumClique

	#Converts Matrix into list of vertices and calls findA
	#in order to find maximum clique
	#params:
	#	graph		-> The adjacency matrix
	#Returns:
	#	List of vertices making up maximum clique
	def find(graph)
		@graph = graph
		@maximumClique = Array.new()
		@savedVertices = Array.new()
		@max = 0
		
		vertexArr = Array.new(@graph.row_count){ |i| (i)}
		findA(vertexArr, 0)
		
		return @maximumClique
	end
	
	#Gets maximum clique as an adjacency matrix
	#Returns:
	#	-Empty matrix if no search has been done
	#	-Matrix of found maximum clique, in the form of an adjacenty matrix
	def getMaxMatrix()
		if(@maximumClique.empty?)
			return Matrix[]
		end
		
		results = Matrix.build(@graph.row_count, @graph.column_count){0}
		for i in 0..@graph.row_count
			for j in 0..@graph.column_count
				if(@maximumClique.include?(i) && @maximumClique.include?(j) && i!=j)
					results[i,j] = 1
				end
			end
		end
		return results
	end
	
	
	#Find the maximum clique
	#params:
	#	vertexArr 	-> List of vertices currently being processed
	#	size		-> Amount of vertices being checked
	def findA(vertexArr, size)
		currentV = Array.new()
		currentV.push(*@savedVertices)
		
		if(vertexArr.length == 0)
			if(size > @max)
				@max = size
				@maximumClique = @savedVertices
			end
			return
		end
		
		if (vertexArr.length != 0)
			if((size + vertexArr.length) <= @max)
				return
			end
			
			for v in vertexArr
				adjacentVertices = Array.new()
				adjAndInArr = Array.new()
				
				vertexArr.delete(v)
				currentV.push(v)
				
				#Get adjacent vertices to v and put them into an array
				for i in 0..@graph.row_count-1
					element = @graph.element(v, i)
					if(element > 0 )
						adjacentVertices.push(i)
					end
				end

				
				#Store all vertices adjacent to v and that are in the vertex array			
				for node in vertexArr
					if(adjacentVertices.include?(node))
						adjAndInArr.push(node)
					end
				end

				@savedVertices = currentV
				
				findA(adjAndInArr, size + 1)
			end
		end
		return
	end
end


#Example use
if __FILE__ == $0
	graph = Matrix[	[0,1,1,1,0],
					[1,0,1,1,0],
					[1,1,0,1,0],
					[1,1,1,0,0],
					[0,0,0,0,0]]

	example = MaximumClique.new
	print example.find(graph)
	puts
	print example.getMaxMatrix()
end


