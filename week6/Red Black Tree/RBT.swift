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
	var isRed: Bool //to determine color of node

	init(element: T, leftChild: RBNode? = nil, rightChild: RBNode? = nil) {
    	self.element = element
		self.leftChild = leftChild
    	self.rightChild = rightChild
		self.isRed = true //default is true since new inserts are red
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
		//make newNode to be the one that's suppose to be on the left of self
			let newNode = RBNode(element: self.element, 
				leftChild: self.leftChild, 
				rightChild: self.rightChild?.leftChild)

			self.element = self.rightChild!.element
			self.rightChild = self.rightChild?.rightChild

			self.leftChild = newNode

			self.isRed = true
		}
	}

	func rotateRight() {
		if self.leftChild != nil {
		//make newNode to be the one that's suppose to be on the right of self

			let newNode = RBNode(element: self.element,
				leftChild: self.leftChild?.rightChild,
				rightChild: self.rightChild)

			self.element = self.leftChild!.element

			self.leftChild = self.leftChild?.leftChild

			self.rightChild = newNode

			self.isRed = true
	    }
	}

	func colorFlip() {
	//change color of current node to red, children to black
		self.isRed = true
		self.leftChild?.isRed = false
		self.rightChild?.isRed = false
	}

  	func balanceTree() {

    	if self.rightChild?.isRed == true {
		//rotate left if right child is red
      		self.rotateLeft()
    	}

    	if (self.leftChild?.isRed == true) && 
		(self.leftChild?.leftChild?.isRed == true) {
		//rotate right if 2 reds in a row
      		self.rotateRight()
    	}

    	if (self.leftChild?.isRed == true) && (self.rightChild?.isRed == true) {
		//flip if 2 red children
      		self.colorFlip()
    	}

		//recursion!
    	self.leftChild?.balanceTree()
    	self.rightChild?.balanceTree()

  	}

	func checkBalanced() -> Bool {

		if self.rightChild?.isRed == true {
			return false
		}

		else if (self.leftChild?.isRed == true) && (self.leftChild?.leftChild?.isRed == true) {
			return false
		}

		else if (self.leftChild?.isRed == true) && 
		(self.rightChild?.isRed == true) {
			return false
		}

		else {

			if self.leftChild?.checkBalanced() == true &&  self.rightChild?.checkBalanced() == true {
				return true
			}

			else {
				return false
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

	init()  {
	}

	func insert( element : T ) {
		if self.isEmpty {
			let newNode = RBNode(element: element)
			self.root = newNode
			self.root!.isRed = false
		}

		else {
			self.root!.insert(element : element)
			self.root!.balanceTree()
		}
	}

	func checkBalanced() -> Bool {
		return self.root!.checkBalanced()
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
