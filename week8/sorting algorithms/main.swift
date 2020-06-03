//
//  main.swift
//  Cedric - Sorting Algos
//  This is an exercise for the Data Structures class. Implement a few sorting algos
//  Created by Cedric on 5/10/20.
//  Copyright © 2020 Cedric Lam. All rights reserved.
//

import Foundation

func test_sorts(){
	let numbers = [11, 10, 16, 19, 14, 0, 3, 7, 17, 12, 9, 5, 2, 18, 4, 1, 13, 15, 6, 8]

	print("Sequence unsorted:", numbers)
	print()
	print("Bubbly sorted:", numbers.bubbleSort())
	print()
	print("Insertion sorted:", numbers.insertionSort())
	print()
	print("Selection sorted:", numbers.selectionSort())
	print()
	print("Heap sorted:", numbers.heapSort())
}

func main() {
	test_sorts()
	
	var shuffledArray = [Int]((0..<1000).shuffled())
	print("Heap:", AverageTimeHeap(shuffledArray))
	print("Sel:", AverageTimeSelection(shuffledArray))
	print("Insertion:", AverageTimeInsertion(shuffledArray))
	print("Bubble:", AverageTimeBubble(shuffledArray))
}

main()
