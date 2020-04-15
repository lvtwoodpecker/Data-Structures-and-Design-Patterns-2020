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
	//calculate maximum height of the tree

		let leftHeight = self.leftChild?.height ?? 0 //if nil, height = 0
		let rightHeight = self.rightChild?.height ?? 0

		//return the longer path among the left and right branch, + 1 for each time it goes down another level
        return max(leftHeight, rightHeight) + 1
    }

	var size : Int {
	//calculate the total number of nodes inside the tree

		let leftSize = self.leftChild?.size ?? 0 //if nil, size = 0
		let rightSize = self.rightChild?.size ?? 0

		//return the number of elements on both branches + root
		return leftSize + rightSize + 1
	}

	var elements : [T] { 
	//return array of all elements in order

		var myArray: [T] = []

		//the root is the middle of the array
		myArray.append(self.element)

		if self.leftChild != nil {
		//add all left children to the left side of the array (smallest first)
			myArray = self.leftChild!.elements + myArray
		}

		if self.rightChild != nil {
		//add all right children to the right side of the array
			myArray = myArray + self.rightChild!.elements
		}

	/*
	it's weird. I tried using "append" for the right children and "insert at: 0" for left, but it couldn't compile saying that the children.elements array wasnt Comparable (hence cannot join the self.element that is Comparable that was already in the array). yet somehow this worked using array concatenation instead. Is it because append and insert are more type sensitive? What's the difference between the two? A quick Google tells me that they're not too much different apart from the runtime.
	*/

		return myArray
	}


	func insert(element: T) {
		let newNode = BSTNode(element: element)

		/*
		if the new node is equal to the current node, do nothing. 
		I'm aware that this is for clarity, but I can just remove the whole line altogether right?
		*/
		if newNode.element == self.element {
			return
		}

		else if newNode.element < self.element {
		/*if newNode is smaller than current node, go to the left branch.
		if there already exists a left child, do it recursively until we find a leftChild = nil. then make that the newNode!
		*/

			if self.leftChild != nil {
				self.leftChild!.insert(element: newNode.element)
			}
			else {
				self.leftChild = newNode
			}
		}

		else if newNode.element > self.element {
		//similar to the left branch
			
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

		else {
			if self.leftChild?.contains(element: element) == true{
				return true
			}

			else if self.rightChild?.contains(element: element) == true {
				return true
			}

			else {
				return false
			}
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
	//let tree take in an array. insert each element of the array to the list
		for element in fromSortedData {
			self.insert(element: element)
		}
	}

	func insert( element : T ) {
		if self.isEmpty {
			let newNode = BSTNode(element: element)
			self.root = newNode
		}
		else {
			self.root!.insert(element : element)
		}
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
	//searching is actually just re-doing the contain function that returns the element

		if self.root!.contains( element: element) {
			return element
		}

		else {
			return nil
		}
	}

	/* after so much time I've finally found something that might work -- add stuff onto a queue and then pop them into the target array. I briefly had that idea for the implementation of the elements (in order) array, but I quickly found a simpler solution afterwards. the process of figuring this out however was such a pain!
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
