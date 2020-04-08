//
//  BST.swift
//  Cedric - Binary Search Tree
//  This is an exercise for the Data Structures class. Implement a Binary Search Tree
//  Created by Cedric on 4/2/20.
//  Copyright © 2020 Cedric Lam. All rights reserved.
//

import Foundation

class BSTNode<T : Comparable> {
	var element: T
	var leftChild: BSTNode?
	var rightChild: BSTNode?

	init(element: T, leftChild: BSTNode? = nil, rightChild: BSTNode? = nil) {
    	self.element = element
		self.leftChild = leftChild
    	self.rightChild = rightChild 
	}

   	var height : Int {
		
		let leftHeight = self.leftChild?.height ?? 0
		let rightHeight = self.rightChild?.height ?? 0

		// return the height of all elements leading up to the first left children + 1 which is the root
        return max(leftHeight, rightHeight) + 1
    }

	var size : Int {
		let leftSize = self.leftChild?.size ?? 0
		let rightSize = self.rightChild?.size ?? 0

		return leftSize + rightSize + 1
	}

	var elements : [T] { //in order
		var myArray: [T] = []

		myArray.append(self.element)

		if self.leftChild != nil {
			myArray = self.leftChild!.elements + myArray
		}

		if self.rightChild != nil {
			myArray = myArray + self.rightChild!.elements
		}

	/*
	it's weird. I tried using "append" for the right children and "insert at: 0" for left, but it couldn't compile saying that the children.elements array wasnt Comparable (unlike the self.element that was already in the array). yet somehow this worked using array concatenation instead. Is it because append and insert are more type sensitive? What's the difference between the two? A quick Google tells me that they're not too much different apart from the runtime.
	*/

		return myArray
	}


	func insert(element: T) {
		let newNode = BSTNode(element: element)

		/*
		if the new node is equal to the current node, do nothing. 
		I'm aware that this is for clarity, but I can just remove it altogether right?
		*/
		if newNode.element == self.element {
			return
		}

		else if newNode.element < self.element {
			
			if self.leftChild != nil {
				self.leftChild!.insert(element: newNode.element)
			}
			else {
				self.leftChild = newNode
			}
		}

		else if newNode.element > self.element {
			
			if self.rightChild != nil {
				self.rightChild!.insert(element: newNode.element)
			}
			else {
				self.rightChild = newNode
			}
		}
	}

	func contains( element : T ) -> Bool {
		if element == self.element {
			return true
		}

		else if element < self.element {
			return self.leftChild!.contains(element: element)
		}

		else if element > self.element {
			return self.rightChild!.contains(element: element)
		}

		else {
			return false
		}

	}

	func  search( element : T ) -> T? {
	//return the stored element if you find it, nil if you don't 
		if self.contains(element: element) {
			return element
		}

		else {
			return nil
		}
	}

}

class BinarySearchTree<T : Comparable> {
	
	var root: BSTNode<T>? = nil

	var height : Int {

		guard !self.isEmpty else {
			return 0
		}
		
		return self.root!.height
	}

	var isEmpty : Bool {
		return self.root == nil
	}

	var size : Int {
		guard !self.isEmpty else {
			return 0
		}
		
		return self.root!.size
	}

	var elements : [T] {
		guard !self.isEmpty else {
			return []
		}	

		return self.root!.elements
	}

	init( fromSortedData : [T] = [] )  {
		for element in fromSortedData {
			self.insert(element: element)
		}
	}

	func insert( element : T ) {
		if self.isEmpty {
			let newNode = BSTNode(element: element)
			self.root = newNode
		}

		self.root!.insert(element : element)
	}

	func contains( element : T ) -> Bool {
		if self.isEmpty {
			return false
		}

		else {
			return self.root!.contains( element : element)
		}
	}

	func search( element : T ) -> T? {
		return self.root!.search( element: element)
	}

	/* after countless hours I've finally found something that might work -- add stuff onto a queue and then pop them into the target array. I briefly had that idea for the implementation of the elements (in order) array, but I quickly found a simpler solution afterwards. this however was such a pain!
	*/

	func makeBreadthFirstArray() -> [T] {
	//Top to bottom, left to right
		var myArray : [T] = []
		var nodeToAppend = self.root
		var myQueue : [BSTNode<T>] = []

		if self.isEmpty == false {
		myQueue.append(nodeToAppend!)

			while myQueue.isEmpty == false {

				nodeToAppend = myQueue.removeFirst()
				myArray.append(nodeToAppend!.element)

				if nodeToAppend!.leftChild != nil {
					myQueue.append(nodeToAppend!.leftChild!)
				}

				if nodeToAppend!.rightChild != nil {
					myQueue.append(nodeToAppend!.rightChild!)
				}
			}
		}

		return myArray
	}
		
}

	// func delete( element : T ) {
	// 	if element == self.root.element {
	// 		self.isEmpty = true
	// 	}

	// 	if deletedElement.leftChild == nil && deletedElement.rightChild == nil {
	// 		deletedElement = nil
	// 	}
	//}
