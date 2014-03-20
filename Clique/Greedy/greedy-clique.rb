require 'matrix'

## Greedy algorithm
# http://msdn.microsoft.com/en-us/magazine/hh547104.aspx

class Greedy_Clique

	def initialize(g="")
		if g == ""
			# random graph
			#@graph = Graph.new(7)

			# graph from link
			@graph = Matrix[ [0,1,0,1,1,0,0,0,0],
			    [1,0,0,1,1,0,0,0,0],
			    [0,0,0,0,1,1,0,0,0],
			    [1,1,0,0,1,0,0,0,0],
			    [1,1,1,1,0,1,0,1,0],
			    [0,0,1,0,1,0,0,0,1],
			    [0,0,0,0,0,0,0,1,0],
			    [0,0,0,0,1,0,1,0,1],
			    [0,0,0,0,0,1,0,1,0]
			]
		else
			@graph = g
		end

		@maxTime = 20
		@targetCliqueSize = @graph.row_size
		@primitive_ops = 0

	end

	def main
		maxClique = find()
		puts maxClique.to_s
		puts "primitive_ops:" + @primitive_ops.to_s
	end

	def find
		clique = Array.new
		rnd = rand()
		time = 0
		timeBestClique = 0
    timeRestart = 0
    nodeToAdd = -1
    nodeToDrop = -1

    #startNode
    start = (0..0).to_a.sample
    clique << start
    @primitive_ops += 1
    puts "Adding node " + start.to_s

    bestClique = Array.new
    bestClique << start
    bestSize = bestClique.length
    timeBestClique = time
    @primitive_ops += 1

    possibleAdd = Array.new
    possibleAdd = MakePossibleAdd(clique)
    oneMissing = Array.new
    oneMissing = MakeOneMissing(clique)

    while time < @maxTime && bestSize < @targetCliqueSize
    	time = time + 1

    	cliqueChanged = false

    	# add node
    	if possibleAdd.length > 0
    		nodeToAdd = GetNodeToAdd(possibleAdd)
    		clique << nodeToAdd
    		@primitive_ops += 1
    		puts "Adding node: " + nodeToAdd.to_s
    		# clique.sort
    		cliqueChanged = true
    		if clique.length > bestSize
    			bestSize = clique.length
    			bestClique = Array.new # clear best
    			for i in 0..clique.length-1
    				bestClique << clique[i]
    				@primitive_ops += 1
    			end
    			timeBestClique = time
    		end
    	end

    	# drop node
    	if cliqueChanged == false
    		# find node in clique which generate max increase in possibleAdd set
            # if more than one, pick one at random
    		if clique.length > 0
    			nodeToDrop = GetNodeToDrop(clique,oneMissing)
    			clique.delete(nodeToDrop)
    			@primitive_ops += 1
    			puts "Dropping node " + nodeToDrop.to_s
    			#clique.sort
    			cliqueChanged = true
    		end
    	end

    	# restart if havent made a change in awhile (added to bestClique or restarted)
    	restart = 2 * bestSize
    	if time - timeBestClique > restart && time - timeRestart > restart
    		timeRestart = time
    		puts "Restarting..."
    		# clear and restart
    		clique = Array.new
    		start = (0..@graph.row_size-1).to_a.sample
    		clique << start
    		@primitive_ops += 1
    		puts "Adding node " + start.to_s
    	end

    	possibleAdd = MakePossibleAdd(clique)
    	oneMissing = MakeOneMissing(clique)
    end

		return bestClique
	end

	#  create list of nodes in graph which are connected to all nodes in clique and therefore will form a larger clique
	def MakePossibleAdd(clique)
		result = Array.new

		for i in 0..@graph.row_size-1
			if FormsALargerClique(clique,i) == true
				@primitive_ops += 1
				result << i
			end
		end

		return result # could be an empty array
	end

	# checks if node is connected to all nodes in clique and makes a bigger clique
	def FormsALargerClique(clique,node)

		# compare nodes to nodes in clique
		for i in 0..clique.length-1
			@primitive_ops += 1
			if clique[i] == node # node already in clique
				return false
			end
			if @graph[node,clique[i]] == 0 # node is not connected
				return false
			end
		end

		return true
	end

	# find node from a List of allowed and possible add which has max degree in posibleAdd
    # there could be more than one, if so, pick one at random
	def GetNodeToAdd(possibleAdd)

		# there is only one node
		if possibleAdd.length == 1
			@primitive_ops += 1
			return possibleAdd[0]
		end

		# look for max degree
		maxDegree = 0
		for i in 0..possibleAdd.length-1
			currNode = possibleAdd[i]
			degreeOfCurrentNode = 0

			for j in 0..possibleAdd.length-1 #count degrees
				otherNode = possibleAdd[j]
				@primitive_ops += 1
				if @graph[currNode,otherNode] == 1
					degreeOfCurrentNode = degreeOfCurrentNode + 1
				end
			end

			if degreeOfCurrentNode > maxDegree
				@primitive_ops += 1
				maxDegree = degreeOfCurrentNode
			end
		end

		# rescan get all nodes with maxDegree
		candidates = Array.new
		for i in 0..possibleAdd.length-1
			currNode = possibleAdd[i]
			degreeOfCurrentNode = 0
			for j in 0..possibleAdd.length-1
				otherNode = possibleAdd[j]
				@primitive_ops += 1
				if @graph[currNode,otherNode] == 1
					degreeOfCurrentNode = degreeOfCurrentNode + 1
				end
			end
			if degreeOfCurrentNode == maxDegree
				@primitive_ops += 1
				candidates << currNode
			end
		end

		if candidates.length == 0
			print "error"
		else
			return candidates.sample
		end
	end

	# find node that will give largest possible set for possibleAdd
	def GetNodeToDrop(clique,oneMissing)
		# only one item in clique
		if clique.length == 1
			@primitive_ops += 1
			return clique[0]
		end

		# find max count
		maxCount = 0
		for i in 0..clique.length-1
			currCliqueNode = clique[i]
			countNotAdjacent = 0
			for j in 0..oneMissing.length-1
				currOneMissingNode = oneMissing[j]
				@primitive_ops += 1
				if @graph[currCliqueNode,currOneMissingNode] == 0
					countNotAdjacent = countNotAdjacent + 1
				end
			end
			if countNotAdjacent > maxCount
				@primitive_ops += 1
				countNotAdjacent = maxCount
			end
		end

		#find candidates with max count
		candidates = Array.new
		for i in 0..clique.length-1
			currCliqueNode = clique[i]
			countNotAdjacent = 0
			for j in 0..oneMissing.length-1
				currOneMissingNode = oneMissing[j]
				@primitive_ops += 1
				if @graph[currCliqueNode,currOneMissingNode] == 0
					countNotAdjacent = countNotAdjacent + 1
				end
			end
			if countNotAdjacent == maxCount
				@primitive_ops += 1
				candidates << currCliqueNode
			end
		end

		if candidates.length == 0
			print "error"
		else
			return candidates.sample
		end
	end

	# make a list of nodes in graph which are connected to all but one of the nodes in clique
	def MakeOneMissing(clique)
		# count - num of nodes in clique which are connected to a candidate node. if final count == (clique size - 1) then candidate is a winner
		
		result = Array.new

		for i in 0..@graph.row_size-1
			count = 0

			sum = @graph.row(i).to_a.reduce :+
			# node i has too few neighbors to possibly be connected to all but 1 node in clique
			if sum >= clique.length - 1
				break
			end
			
			# check if i is in clique
			if !(clique.include? i)
				break
			end

      # count num nodes in clique connected to i
      for j in 0..clique.length-1
      	@primitive_ops += 1
      	if @graph[i,clique[j]] == 1
      		count = count + 1
      	end
      end
      if count == clique.length-1
      	@primitive_ops += 1
      	result << i
      end
    end
        
    return result

	end

end

g = Greedy_Clique.new
g.main