//
//  sorting.swift
//  Cedric - Sorting Algos
//  This is an exercise for the Data Structures class. Implement a few sorting algos.
//  Created by Cedric on 5/10/20.
//  Copyright © 2020 Cedric Lam. All rights reserved.
//

import Foundation

extension Array where Element : Comparable {

	func sorted() -> Bool {
		let array = self

		for x in 0..<(array.count - 1) {
			if array[x] > array[x+1] {
				return false
			}
		}

		return true
	}

	func bubbleSort() -> Array {
	//starting with bubble sort cos bubble is cool

		var array = self

		while !array.sorted() {
			for x in 0..<(self.count - 1) {
				if array[x] > array[x+1] {
					array.swapAt(x, x+1)
				}
			}
		}

		return array
	}

	func insertionSort() -> Array {
		var array = self
		for x in 1...(self.count - 1) {
			
			let temp = array[x]
			var currentIndex = x - 1

			while currentIndex >= 0 && temp < array[currentIndex] {
				array[currentIndex + 1] = array[currentIndex]
				currentIndex -= 1
			}

			array[currentIndex + 1] = temp
		}
		return array

	}

	func selectionSort() -> Array {
		var array = self

		for x in 0..<(self.count - 1) {
			var smallestIndex = x

			for i in x..<self.count {
				if array[i] < array[smallestIndex] {
					smallestIndex = i
				}
			}
			array.swapAt(x, smallestIndex)
		}

		return array
	}

	func heapSort()-> Array {
		let heapified = Heap(self)

		for i in stride(from: self.count - 1, through: 0, by: -1) {
			heapified.heap.swapAt(0, i)
		}
		//the smallest element always end up at the end of the array, so need to move it to the top. I need to change this without touching the heap so as to screw up everything.
		//making a new array instead.
		var array = heapified.heap

		let lastEle = array.removeLast()
		array.insert(lastEle, at: 0)

		return array
	}
}
