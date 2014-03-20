import java.util.Random;

public class GraphGen {
	
	static Random r = new Random();
	
	//Returns a randomly generated directed graph
	public static int[][] generate(int n,double avg){
		int graph[][] = new int[n][n];
		for (int i=0;i<n;i++){
			for (int j=0;j<n;j++){
				if (i==j){
					graph[i][j] = 0;
				}
				else if(r.nextFloat()<avg){
					graph[i][j] = 1;
				}
				else graph[i][j] = 0;
			}
		}
		return graph;
	}
}
