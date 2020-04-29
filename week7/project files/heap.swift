//
//  heap.swift
//  Cedric - Heap
//  This is an exercise for the Data Structures class. Implement a heap, queue, and do problems with Huffman Encoding
//  Created by Cedric on 4/20/20.
//  Copyright © 2020 Cedric Lam. All rights reserved.
//

import Foundation

class Heap<T : Comparable> {
	var heap: [T] = []

	init( fromSortedData : [T] = [] )  {
	//let tree take in an array. insert each element of the array to the list
		for element in fromSortedData {
			self.insert(element: element)
		}
	}

	func parentIndex(_ index: Int) -> Int {
	//return index of parent of an element
		return (index - 1) / 2
	}

	func leftIndex(_ index : Int) -> Int{
	// left child of element at index
		return (index * 2) + 1
	}

	func rightIndex(_ index : Int) -> Int {
		return (index * 2) + 2
	}

	func insert(element : T) {
		
		self.heap.append(element)

		var currentIndex = self.heap.count - 1
		var parent = parentIndex(currentIndex)

		//there's a function called swapAt in Array :o
		while currentIndex != 0 && self.heap[parent] > self.heap[currentIndex] {
				self.heap.swapAt(currentIndex, parent)
				currentIndex = parent
				parent = parentIndex(currentIndex)
		}
	}

	func extractMin() -> T {

		let last = self.heap.count - 1
		self.heap.swapAt(0, last)

		var left = leftIndex(0)
		var right = rightIndex(0)
		var currentIndex = 0

		let root = self.heap.popLast()!

		while heap[currentIndex] > heap[left] {
			heap.swapAt(0, left)
			currentIndex = left

			left = leftIndex(left)
		} 

		while heap[currentIndex] > heap[right] {
			heap.swapAt(0, right)
			currentIndex = right

			right = rightIndex(right)
		}

		return root
	}

	var isEmpty : Bool {
		return self.heap.isEmpty
	}
}
