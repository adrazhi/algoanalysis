package Clique;

import java.util.Collections;
import java.util.Random;
import java.util.LinkedList;

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
	
	//Returns a randomly generated un-directed graph
		public static int[][] generateUD(int n,double avg){
			int graph[][] = new int[n][n];
			for (int i=0;i<n;i++){
				for (int j=0;j<i;j++){
					if (i==j){
						graph[i][j] = 0;
					}
					else if(r.nextFloat()<avg){
						graph[i][j] = 1;
						graph[j][i] = 1;
					}
					else graph[i][j] = 0;
				}
			}
			return graph;
		}
		
		//PRE: k <= n
		//POST:returns a clique of size k (n choose k)
		public static int[] generateClique(int n, int k){
			int clique[] = new int[k];
			LinkedList<Integer> c = new LinkedList<Integer>();
			//adds 0 - n to c
			for(int i=0;i<n;i++) c.add(i);
			Collections.shuffle(c);
			
			for(int i=0;i<k;i++) clique[i] = c.remove();
			
			return clique;
		}
		
		//Includes the clique into graph g
		//g is guaranteed to have a clique of size of at least clique.length
		public static int[][] includeClique(int clique[], int g[][]){
			
			int graph[][] = g;
			for(int i=0;i<clique.length;i++){
				for(int j=0;j<i;j++){
					graph[clique[i]][clique[j]] = 1;
					graph[clique[j]][clique[i]] = 1;
				}
			}
			return graph;
			
		}
	
}
