//
//  RedBlackTree.swift
//  Cedric - Red Black Tree
//  This is an exercise for the Data Structures class. Implement a Red Black Tree, which is a binary search tree but optimized?
//  Created by Cedric on 4/11/20.
//  Copyright © 2020 Cedric Lam. All rights reserved.
//

import Foundation

class RBNode<T : Comparable> {
/* Rules:
Every node is either red or black
Red on the left
No consecutive red
Only one red child
New node is always red.
Root is black as a result (or else nothing can work lol)
*/

	var element: T
	var leftChild: RBNode?
	var rightChild: RBNode?
	var isRed: Bool? //to determine color of node

	init(element: T, leftChild: RBNode? = nil, rightChild: RBNode? = nil, isRed: Bool? = true) {
    	self.element = element
		self.leftChild = leftChild
    	self.rightChild = rightChild
		self.isRed = isRed //default is true since new inserts are red
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

		return myArray
	}

	func insert(element: T) {
		let newNode = RBNode(element: element)

		// if the new node is equal to the current node, do nothing. 
		//
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

	func rotateLeft() {
		if self.rightChild != nil {

			//if only the right child is red, then rotate
			if self.rightChild!.isRed! && self.leftChild!.isRed! == false {
		
				let newNode = self.rightChild!
				self.rightChild = newNode.leftChild
				//change current node to left child of new node
				newNode.leftChild = self

				//change the colors accordingly
				newNode.isRed = self.isRed
				self.isRed = true
			}

			else {
				self.rightChild!.rotateLeft()
			}
		}
		else {
			return
		}
	}

	func rotateRight() {
		if self.leftChild != nil {

			//if 2 in a row is red, rotate
			if self.leftChild!.isRed! && self.leftChild!.leftChild!.isRed! {

				let newNode = self.leftChild!
				self.leftChild = newNode.rightChild
				newNode.rightChild = self

				//change color accordingly
				newNode.isRed = self.isRed
				self.isRed = true
			}

			else {
				self.leftChild!.rotateRight()
			}
		}
		else {
			return
		}	
	}

	func colorFlip() {
		if self.leftChild != nil {
			//if both children are red, flip color
			if self.rightChild!.isRed! && self.leftChild!.isRed! {
				self.isRed = true
				self.rightChild?.isRed = false
				self.leftChild?.isRed = false
			}

			else {
				self.leftChild!.colorFlip()
			}
		}

		else if self.rightChild != nil {
			//if both children are red, flip color
			if self.rightChild!.isRed! && self.leftChild!.isRed! {
				self.isRed = true
				self.rightChild?.isRed = false
				self.leftChild?.isRed = false
		}

			else {
				self.rightChild!.colorFlip()
			}
		}
		else {
			return
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

class RedBlackTree<T : Comparable> {
	
	var root: RBNode<T>? = nil

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

	func balanceTree() {
		self.root?.rotateRight()
		self.root?.rotateLeft()
		self.root?.colorFlip()
	}

	func insert( element : T ) {
		if self.isEmpty {
			let newNode = RBNode(element: element, isRed: false)
			self.root = newNode
		}

		else {
			self.root!.insert(element : element)
		}

		self.balanceTree()
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

	func makeBreadthFirstArray() -> [T] {
	//Top to bottom, left to right
		var myArray : [T] = []
		var nodeToAppend = self.root
		var myQueue : [RBNode<T>] = []

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
