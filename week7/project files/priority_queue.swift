//
//  priority_queue.swift
//  Cedric - priority_queue
//  This is an exercise for the Data Structures class. Implement a heap, queue, and do problems with Huffman Encoding
//  Created by Cedric on 4/20/20.
//  Copyright © 2020 Cedric Lam. All rights reserved.
//

class PriorityQueue <T: Comparable> {
    var queue = Heap<T>()

	//maybe add the item to arary and prioity to the heap? IDK how.

    var isEmpty: Bool {
       return queue.isEmpty
    }

	func insert(element : T, withPriority : Int) {
		queue.insert(element : element)
	}

	func pullHighestPriority() -> T {
		return queue.extractMin()
	}
    
}

/* 
I cant seem to figure out the prio queue :/ it'so... illogical?? For example in a prio queue with 1 as the highest priority, an element of value 10 with priority of 1 would be on top right? How do you keep track of two things at once? I think it's doable if I use nodes for heap, but I didn't, so how can I store both the priority and the element in the heap value? 

My main concern was if there are elements with the same priority, but different value (like 1 and 10 both have priority of 1, which means that 1 should be in front of 10). How do I evaluate this? I tried keeping a count but then I realized I'd need to keep a count for every priority value in the queue which is not ideal. I'm so confused,though this SHOULD be pretty easy to implement :|
*/
