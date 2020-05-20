//
//  heap.swift
//  Cedric - Heap
//  This is an exercise for the Data Structures class. Implement a heap, queue, and do problems with Huffman Encoding
//  Created by Cedric on 4/20/20.
//  Copyright © 2020 Cedric Lam. All rights reserved.
//

import Foundation

enum IndexError: Error {
	case EmptyHeap
}

class Heap<T : Comparable> {
	var heap: [T] = []

	init(_ fromSortedData : [T] = [] )  {
	//let tree take in a sorted Array
		for element in fromSortedData.sorted() {
			heap.append(element)
		}
	}	
	func parentIndex(_ index: Int) -> Int {
	//return index of parent of an element
		return (index - 1) / 2
	}

	func leftIndex(_ index : Int) -> Int {
	// left child of element at index
		return (index * 2) + 1
	}

	func rightIndex(_ index : Int) -> Int {
		return (index * 2) + 2
	}

	func insert(element : T) {
		
		heap.append(element)

		var currentIndex = heap.count - 1
		var parent = parentIndex(currentIndex)

		//there's a function called swapAt in Array :o
		while currentIndex != 0 && heap[parent] >  heap[currentIndex]{
				heap.swapAt(currentIndex, parent)
				currentIndex = parent
				parent = parentIndex(currentIndex)
		}
	}

	func extractMin() throws -> T {
		
		guard !heap.isEmpty else {
			throw IndexError.EmptyHeap
		}
		//swap last and first element
		let last = heap.count - 1
		self.heap.swapAt(0, last)
		let root = heap.popLast()!

		//Reordering the heap
		var currentIndex = 0
		var left = leftIndex(0)
		var right = rightIndex(0)

		if heap.count > 3 {
		//loop applies to heaps with valid left and right children only
			while 	heap[currentIndex] > heap[left] || heap[currentIndex] > heap[right] {
					
				if heap[left] <= heap[right] {
					heap.swapAt(currentIndex, left)
					currentIndex = left
				}

				else {
					heap.swapAt(currentIndex, right)
					currentIndex = right
				}

				left = leftIndex(currentIndex)
				right = rightIndex(currentIndex)

				if left > (heap.count - 1) || right > heap.count - 1{
					break
				}
			}
		}

		else {
			/*
			I found out a shortcut: if heap has 3 elements, after popping last I just need to reverse it to get the correct ordering. If heap has 1 or 2 elements, the order doesn't matter after popping, since heap would only have 0 or 1 element.
			*/
			heap.reverse()
		}


		return root
	}

	var isEmpty : Bool {
		return heap.isEmpty
	}
}
