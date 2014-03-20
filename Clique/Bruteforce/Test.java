package Clique;

import java.util.Arrays;
import java.util.Collections;
import java.util.LinkedList;

public class Test {
	

	public static void main(String[] args) {
		
		int n = 10;
		double avg = .1;
		
		int clique[] = GraphGen.generateClique(n, 4);
		int graph[][] = GraphGen.includeClique(clique, GraphGen.generateUD(n,avg));
		
		
		
		System.out.print("Clique:  ");
		for(int i=0;i<clique.length;i++)
			System.out.print(clique[i]+" ");
		System.out.println();
		System.out.println("-----------------");
		for (int i=0;i<n;i++){
			for(int j=0;j<n;j++) System.out.print(graph[j][i] + " ");
			System.out.println();
		}
		System.out.println();
		System.out.print("Clique put in: ");
		for(int i=0;i<clique.length;i++){
			System.out.print(clique[i]+",");
		}
		System.out.println();
		
		printClique(graph,4);
	}
	
	public static void printCombos(LinkedList<LinkedList<Integer>> combo){
		int c = combo.size();
		for(int i=0;i<c;i++){
			System.out.print("(");
			int cSub = combo.get(i).size();
			for(int j=0;j<cSub;j++){
				System.out.print(combo.get(i).get(j)+",");
			}
			System.out.print("),");
		}
		
	}
	
	public static void printClique(int graph[][], int k){
		int clique[] = BruteForce.getClique(graph, k);
		if(clique == null){
			System.out.print("No cliques of size " + k);
		}
		else{
			System.out.print("Clique found: ");
			for(int i=0;i<clique.length;i++){
				System.out.print(clique[i]+",");
			}
		}
	}
	
	
}
