//
//  graph.swift
//  Cedric - Graph
//  This is an exercise for the Data Structures class. Implement a graph
//  Created by Cedric on 4/20/20.
//  Copyright © 2020 Cedric Lam. All rights reserved.
//

//I'm planning to use the adjacency table to implement this graph.

class Graph<T> {
	//number of vertices
	let vertices: Int
	//make an array containing an array for each vertex. Total number of arrays = number of vertices
	var vertexArray = [[Int]]()

	init(vertices: Int) {
		self.vertices = vertices

		for _ in 0..<vertices {
			self.vertexArray.append([])
		}
	}

	func addEdge( firstVertex : Int, secondVertex : Int ) {
		/*Add the second element to the array with index of the first vertex, do the same for the second vertex. The graph is not directed so this makes sense.

		After that, sort the list so that the adjacency array looks nicer. I'm not sure if this is needed but I feel like it's better that way!
		*/
		vertexArray[firstVertex].append(secondVertex)
		vertexArray[secondVertex].append(firstVertex)

		vertexArray[firstVertex].sort()
		vertexArray[secondVertex].sort()
	}

	func removeEdge( firstVertex : Int, secondVertex : Int ) {
		//same logic as adding addEdge
		//one check is probably enough, but I'm keeping the comments below just in case there are cases that need it
		if vertexArray[firstVertex].contains(secondVertex) {
			vertexArray[firstVertex] = vertexArray[firstVertex].filter {$0 != secondVertex}

			vertexArray[secondVertex] = vertexArray[secondVertex].filter {$0 != firstVertex}
		} 
	}

	func neighborsOf( vertex : Int ) -> [Int] {
		return vertexArray[vertex]
	}

	func verticesAreAdjacent( firstVertex : Int, secondVertex : Int ) -> Bool {

		if vertexArray[firstVertex].contains(secondVertex) {
			return true
		}
		else {return false}
	}

	func verticesAreConnected(firstVertex : Int, secondVertex : Int) -> Bool {
		return breadthFirstSearch(firstVertex).contains(secondVertex)
	}


	func breadthFirstSearch(_ start : Int) -> [Int] {
	//doing this just to understand how to do the shortest path search

		//make an array to check if a vertex is marked or not 
		var marked = Array(repeating: false, count: self.vertices)

		var outputList: Array<Int> = []

		//make a queue to add vertices in
		var queue: Array<Int> = []

		//if the first vertex is connected, enqueue then mark it
		if !vertexArray[start].isEmpty {
			queue.append(start)
			marked[start] = true
		}

		else {print("It's not connected to anything :(")}

		while !queue.isEmpty {
				let currentVertex = queue.removeFirst()
				outputList.append(currentVertex)
				
				for i in vertexArray[currentVertex] {
					if marked[i] == false {
						queue.append(i)
						marked[i] = true
					}
				}	
			}

			return outputList
	}

	func shortestPathFrom(_ start: Int, to end: Int) -> [Int] {
	//this still seems wrong but I cannot find a problem with it. Help!
		//make an array to check if a vertex is marked or not 
		var marked = Array(repeating: false, count: self.vertices)

		var outputList: Array<Int> = []

		if !vertexArray[start].contains(end) {
			//make a queue to add vertices in
			var queue: Array<Int> = []

			//if the first vertex is connected, enqueue then mark it
			if !vertexArray[start].isEmpty {
				queue.append(start)
				marked[start] = true
			}

			var previousVertex = start

			while !queue.isEmpty {
				let currentVertex = queue.removeFirst()
				
				for i in vertexArray[currentVertex] {
					if marked[i] == false {
						queue.append(i)
						marked[i] = true
						previousVertex = currentVertex
					}
				}
				
				if currentVertex == end {
					outputList.append(currentVertex)
					break
				}
				if !outputList.contains(previousVertex) {
				outputList.append(previousVertex)
				}
			}

		} else {outputList = [start, end]}

		if outputList.contains(end) {
			return outputList
		} else {return []}
	}

	func hasCycle() -> Bool {
	//Why is this code not running :(. Segmentation error???

		//make an array to check if a vertex is marked or not 
		var marked = Array(repeating: false, count: self.vertices)
		var cycle = 0

		while marked.contains(false) {
			let currentVertex = marked.firstIndex(of: false)

			marked[currentVertex!] = true

			for i in neighborsOf(vertex : currentVertex!) {
            	if marked[i] == false {
					_ = self.hasCycle()
				}

				else {
					cycle = 1
					break
				}
			}
		}

		return cycle == 1
	}

}
