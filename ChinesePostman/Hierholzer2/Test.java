import java.util.LinkedList;
public class Test {

	public static void main(String[] args) {
		int n = 4;
		int graph[][] = GraphGen.generate(n,.99);
		
//		int graph[][] = new int[n][n];
//		graph[0][1]=1;
//		graph[1][2]=1;
//		graph[2][3]=1;
//		graph[3][0]=1;
//		graph[0][0]=1;
//		graph[2][3]=1;
//		graph[3][1]=1;
//		graph[3][2]=1;
		
		for (int i=0;i<n;i++){
			for (int j=0;j<n;j++){
				System.out.print(graph[j][i]+" ");
			}
			System.out.println();
		}
		System.out.println("----------------------");
		
		
		//Show if it's cyclic and if it's connected
		if(Hierholzer.hasComponent(graph))
			System.out.println("Vertices are Even");
		
		else
			System.out.println("At least 1 vertex isn't even");
		
		if(Hierholzer.isConnected(graph) == true)
			System.out.println("And g is Connected");
		else
			System.out.println("And g is NOT Connected");
		
		System.out.println("Edges:   "+Hierholzer.numEdges(Hierholzer.justEdges(graph)));
		
		LinkedList<Integer> fin = Hierholzer.findCycle(graph);
		
		if(fin == null) System.out.print("Cycle:  No Cycle Exists :/");
		
		else{
			System.out.println("Cycle:   ");
			int size = fin.size();
			for(int i=0;i<size;i++){
				System.out.print(fin.remove()+",  ");
			}
			System.out.println();
			System.out.println("Size:    "+size);
		}		
	}
}
