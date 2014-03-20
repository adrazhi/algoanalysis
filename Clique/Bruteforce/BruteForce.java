package Clique;

import java.util.LinkedList;

public class BruteForce {

	//Returns true if c is a clique
	public static boolean checkClique(int c[], int graph[][]){
		
		for (int i=0;i<c.length;i++){
			for (int j=0;j<c.length;j++){
				if(i!=j && graph[c[i]][c[j]] == 0)
					return false;
			}
		}		
		return true;
	}
	
	
	//Returns a clique of size k 
	//or a null array if none exist
	public static int[] getClique(int graph[][],int k){
		int n = graph.length;
		
		LinkedList<Integer> clique = new LinkedList<Integer>();
		
		//Looks for all vertices that have at least k-1 edges (not including itself)
		for(int i=0;i<n;i++){
			int sum =0;
			//Counts edges connected to i
			for(int j=0;j<n;j++) sum+=graph[i][j];
			if (sum >= k-1) clique.add(i);
		}
		
		//Checks to make sure that each vertex has at least k edges connected to vertices in the array
		int c = clique.size();
		LinkedList<Integer> temp = new LinkedList<Integer>();
		for(int i=0;i<c;i++){
			int sum = 0;
			for(int j=0;j<c;j++) sum+=graph[clique.get(i)][clique.get(j)];
			if(sum<k-1) temp.add(i);
		}
		int t = temp.size();
		for(int i=0;i<t;i++) clique.remove(temp.get(i));
		
		
		//Converts clique to an array
		int cliqueArray[] = toArray(clique);
		
		//Gets all possible cliques of size k
		LinkedList<LinkedList<Integer>> combo = combinations(cliqueArray,k);
		int comboSize = combo.size();
		
		//If one of the elements of combo is a clique, return it
		for(int i=0;i<comboSize;i++){
			int next[] = toArray(combo.remove());
			if(checkClique(next,graph))
				return next;
		}
		
		return null;
	}
	
	
	//PRE: k<possClique.length
	//POST:Returns all combinations of size k in clique possibilities (C choose K)
	public static LinkedList<LinkedList<Integer>> combinations (int possClique[], int k){
		int c = possClique.length;
		LinkedList<LinkedList<Integer>> combo = new LinkedList<LinkedList<Integer>>();
		
		if (k == 1){
			
			for (int i=0;i<c;i++){
				LinkedList<Integer> subSub = new LinkedList<Integer>();
				subSub.add(possClique[i]);
				combo.add(subSub);
			}

		}
		
		else {
			for (int i = 0; i < c-k+1; i++) {
				LinkedList<LinkedList<Integer>> sub = new LinkedList<LinkedList<Integer>>();
				int subClique[] = new int[c - i - 1];
				for (int j = 0; j < c - i - 1; j++)
					subClique[j] = possClique[j + i + 1];

				sub = combinations(subClique, k - 1);
				int s = sub.size();
				for (int j = 0; j < s; j++)
					sub.get(j).add(0, possClique[i]);

				for (int j = 0; j < s; j++)
					combo.add(sub.remove());
			}
		}
		return combo;
	}
	
	//Converts LinkedList<Integer> to an int array
	public static int[] toArray(LinkedList<Integer>clique){
		int size = clique.size();
		int array[] = new int[size];
		for(int i=0;i<size;i++) array[i] = clique.remove();
		
		return array;
	}
	
	public static int getCliquePO(int graph[][],int k){
		int n = graph.length;
		
		int po = 0;
		
		LinkedList<Integer> clique = new LinkedList<Integer>();
		
		//Looks for all vertices that have at least k-1 edges (not including itself)
		for(int i=0;i<n;i++){
			int sum =0;
			//Counts edges connected to i
			for(int j=0;j<n;j++) sum+=graph[i][j];
			if (sum >= k-1) clique.add(i);
		}
		
		//Checks to make sure that each vertex has at least k edges connected to vertices in the array
		int c = clique.size();
		LinkedList<Integer> temp = new LinkedList<Integer>();
		for(int i=0;i<c;i++){
			int sum = 0;
			for(int j=0;j<c;j++) sum+=graph[clique.get(i)][clique.get(j)];
			if(sum<k-1) temp.add(i);
		}
		int t = temp.size();
		for(int i=0;i<t;i++) clique.remove(temp.get(i));
		
		
		//Converts clique to an array
		int cliqueArray[] = toArray(clique);
		
		//Gets all possible cliques of size k
		LinkedList<LinkedList<Integer>> combo = combinations(cliqueArray,k);
		
		int comboSize = combo.size();
		po += comboSize;
		
		//If one of the elements of combo is a clique, return it
		for(int i=0;i<comboSize;i++){
			int next[] = toArray(combo.remove());
			if(checkClique(next,graph))
				return po;
		}
		
		return po;
	}
}
