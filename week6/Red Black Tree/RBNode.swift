//
//  RBNode.swift
//  Cedric - Red Black Tree
//  Node class file
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

			if self.leftChild?.checkBalanced() == false ||  		  self.rightChild?.checkBalanced() == false {
				return false
			}

			else {
				return true
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
