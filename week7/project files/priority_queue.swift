//
//  priority_queue.swift
//  Cedric - priority_queue
//  This is an exercise for the Data Structures class. Implement a heap, queue, and do problems with Huffman Encoding
//  Created by Cedric on 4/20/20.
//  Copyright © 2020 Cedric Lam. All rights reserved.
//

struct PriorityQueueNode <T: Comparable>: Comparable {
	var element: T
	var priority: Int

	init(_ value: T, priority: Int) {
		self.element = value
		self.priority = priority
	}

	static func ==(_ lhs: PriorityQueueNode, _ rhs: PriorityQueueNode) -> Bool {
		return lhs.priority == rhs.priority
	}

	static func <(_ lhs: PriorityQueueNode, _ rhs: PriorityQueueNode) -> Bool {
		return lhs.priority < rhs.priority
	}
}

class PriorityQueue <T: Comparable> {
    var queue: [PriorityQueueNode<T>] = []

    var isEmpty: Bool {
       return queue.isEmpty
    }

	func sortQueue() {
        queue = queue.sorted(by: < )
	}

	func insert(element : T, withPriority : Int) {
		//if the element is already there, update it with the new prio
		if queue.contains(where: {$0.element == element}) {

			//get that specific element using filter. Using if var because that element might be optional.
			if var elementToUpdate = queue.filter({ $0.element == element }).first {

				elementToUpdate.priority = withPriority
				sortQueue()
			}
		}
		
		else {
			let newNode = PriorityQueueNode<T>(element, priority: withPriority)

			queue.append(newNode)
			sortQueue()
		}
	}

	func pullHighestPriority() -> T? {
		guard isEmpty == false else {
			return nil
		}
		return queue.removeFirst().element
	}
    
}
