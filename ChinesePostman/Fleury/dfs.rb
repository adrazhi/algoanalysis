# Depth-first search (DFS) is an algorithm for traversing or
# searching a tree, tree structure, or graph. One starts at 
# the root (selecting some node as the root in the graph case)
# and explores as far as possible along each branch before backtracking.
#
# A graph can be represented by its adjacency matrix G,
# where G[i][j] == 1 if there is an edge between 
# vertices i and j and 0 otherwise.
#
# Below Graph in diagram http://i.imgur.com/sV1UzUn.png
G = [0,1,1,0,0,1,1], # A
    [1,0,0,0,0,0,0], # B
    [1,0,0,0,0,0,0], # C
    [0,0,0,0,1,1,0], # D
    [0,0,0,1,0,1,1], # E
    [1,0,0,1,1,0,0], # F
    [1,0,0,0,1,0,0]  # G
 
LABELS = %w(A B C D E F G)

@found = false
 
def dfs(vertex,find="")
  # mark v as explored
  print "#{LABELS[vertex]} " # visited

  # nullify the row to mark the
  # vertex as visited
  edge = 0
  while edge < G.size
    G[vertex][edge] = 0
    edge += 1
  end

  # check if its the vertex we're looking for
  if (LABELS[vertex] == find)
    #print "found"
    @found = true
  end
 
  # Find unexplored edges
  edge = 0
  while edge < G.size && !@found
    # not explored and not same vertex
    if ( G[edge][vertex] != 0 && edge != vertex)
      dfs(edge,find)
    end
    edge += 1
  end

end
 
dfs(0,"G") # Replace 0 with 1..6 to see different paths