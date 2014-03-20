import java.util.LinkedList;

public class Hierholzer {
	
	//Returns the path taken to form an Eulerian cycle starting with vertex 0
	//The array returned is of size n^2 (since worst case, E = n^2)
	public static LinkedList<Integer> findCycle(int graph[][]){
				
		//checks that each vertex has equal in-edges and out-edges
		//otherwise an eulerian cycle doesn't exist
		if(!hasComponent(graph)) return null;
		
		if(!isConnected(graph)) return null;
		
		int n = graph.length;
		//List of visited vertices (0 = unvisited)
		int c[] = new int[n];
		for(int i=0;i<n;i++)
			c[i] = 0;
		
		//List of visited edges
		LinkedList<Integer> fin = new LinkedList<Integer>();
		//List of unvisited edges
		LinkedList<Integer> v[] = justEdges(graph);
		
		//Total number of edges
		int e = numEdges(v);
		
		fin.add(0);
		while(fin.size()<e){
			
			if(getNextVertex(v,fin)==-1){
				return fin;
			}
			
			//current vertex
			int cv = getNextVertex(v,fin);
			int nv = v[cv].remove();
			
			LinkedList<Integer> sub = new LinkedList<Integer>();
			
			//generates a sub cycle
			while(cv!=nv){
				sub.add(nv);
				nv = v[nv].remove();
			}
			sub.add(cv);
			
			fin.addAll(fin.indexOf(cv)+1,sub);
		}
		
		return fin;
	}
	
	
	/*
	 * Returns the list of edges in an array
	 * The list in each index i represents 
	 * the out edges for vertex i
	 */
	public static LinkedList<Integer>[] justEdges(int graph[][]){
		int n = graph.length;
		
		LinkedList<Integer> edges[] = new LinkedList[n];
		for (int i=0;i<n;i++){
			edges[i] = new LinkedList<Integer>();
		}
		
		for(int i=0;i<n;i++){
			for(int j=0;j<n;j++){
				if(graph[i][j] == 1){
					edges[i].add(j);
				}
			}
		}
		return edges;
	}
	
	//Returns the overall size of v
	public static int numEdges(LinkedList<Integer> v[]){
		int size = 0;
		for(int i=0;i<v.length;i++){
			for(int j=0;j<v[i].size();j++){
				size++;
			}
		}
		
		return size;
	}
	
	//PRE: There exists a visited vertex in fin that has an unused edge
	//POST:Gets the next visited vertex that still has unused edges
	public static int getNextVertex(LinkedList<Integer> v[], LinkedList<Integer> fin){
		
		for(int i=0;i<v.length;i++){
			if(fin.contains(i)){
				if(v[i].size()!= 0)
					return i;
			}
		}
		
		return 0;
	}
	
	//Returns true if there are the same number of 
	//in-edges to out-edges for each vertex
	public static boolean hasComponent(int graph[][]){
		
		int n = graph.length;
		
		for (int i=0;i<n;i++){
			int outEdges = 0;
			int inEdges = 0;
			for (int j=0;j<n;j++){
				outEdges += graph[i][j];
				inEdges += graph[j][i];
			}
			if(outEdges!=inEdges)
				return false;
		}
		
		return true;
	}
	
	//Returns true if every vertex is reachable by vertex 0
		public static boolean isConnected(int graph[][]){
			int n = graph.length;
			//collection of sub-graphs
			int c[] = new int[n];
			for(int i=0;i<n;i++)
				c[i] = i;
				
			//Quick Union
			for(int i=0;i<n;i++){
				for(int j=0;j<i;j++){
					if (graph[i][j] == 1 || graph[j][i] == 1){
						//vertex j is added to set with i (smallest is parent)
						if(c[i]<c[j])
							c[j] = c[i];
						else c[i] = c[j];
					}
				}
			}
			//if there is a vertex that doesn't belong to 0's set, it's not connected
			for (int i=0;i<n;i++){
				boolean searching = true;
				while (searching){
					if(c[i] == 0)
						searching = false;
					else if(c[i] == i)
						return false;
					else
						c[i] = c[c[i]];
				}
			}

			return true;
		}
		
		//Returns primitive ops of findCycle
		public static int findCyclePO(int graph[][]){
			
			//checks that each vertex has equal in-edges and out-edges
			//otherwise an eulerian cycle doesn't exist
			if(!hasComponent(graph)) return 0;
			
			if(!isConnected(graph)) return 0;
			
			int po = 0;
			
			int n = graph.length;
			//List of visited vertices (0 = unvisited)
			int c[] = new int[n];
			for(int i=0;i<n;i++)
				c[i] = 0;
			
			//List of visited edges
			LinkedList<Integer> fin = new LinkedList<Integer>();
			//List of unvisited edges
			LinkedList<Integer> v[] = justEdges(graph);
			
			//Total number of edges
			int e = numEdges(v);
			po+=e;
			
			fin.add(0);
			while(fin.size()<e){
				
				if(getNextVertex(v,fin)==-1){
					return -1;
				}
				
				//current vertex
				int cv = getNextVertex(v,fin);
				int nv = v[cv].remove();
				
				LinkedList<Integer> sub = new LinkedList<Integer>();
				
				//generates a sub cycle
				while(cv!=nv){
					sub.add(nv);
					nv = v[nv].remove();
					po++;
				}
				sub.add(cv);
				
				fin.addAll(fin.indexOf(cv)+1,sub);
				po+=sub.size();
			}
			
			return po;
		}
}
