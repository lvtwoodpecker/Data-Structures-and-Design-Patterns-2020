//
//  main.swift
//  Cedric - Heap + Queue + Huffman Encoding
//  This is an exercise for the Data Structures class. Implement a heap, queue, and do problems with Huffman Encoding
//  Created by Cedric on 4/20/20.
//  Copyright © 2020 Cedric Lam. All rights reserved.
//

import Foundation

//driver file
func test_heap(){
	let heap = Heap<Int>([3, 2, 1, 4, 5])
	heap.insert(element: 3)
	heap.insert(element: 2)
	heap.insert(element: 1)
	heap.insert(element: 5)
	heap.insert(element: 4)
	print(heap.heap)
	let min_element = heap.extractMin()
	print(min_element)
	print(heap.heap)
}

func main (){
	test_heap()
}

main()
