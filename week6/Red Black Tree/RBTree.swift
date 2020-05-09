//
//  RBTree.swift
//  Cedric - Red Black Tree
//  Red black tree class
//  Created by Cedric on 4/11/20.
//  Copyright © 2020 Cedric Lam. All rights reserved.
//

import Foundation

enum RBTError: Error {
	case arrayNotSorted
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
	// I couldn't figure out recursion in the initializer for insertFromSorted so I added a function instead. Maybe a bit cheating-ish but it works!

	self.root = try! self.insertFromSorted(fromSortedData)
	}

	func insertFromSorted (_ sortedArray : [T] = []) throws -> RBNode<T>? {
	//array sorted, so use this to split it into 2 halves!

		//check if array is empty/unsorted in case someone is trolling
		guard !sortedArray.isEmpty else {return nil}
		guard sortedArray.sorted() == sortedArray else {
			throw RBTError.arrayNotSorted
		}

		//find the middle point of the array
		let endIndex = sortedArray.endIndex	
		let middleIndex = endIndex / 2

		//make the middle point the root, then the middle points of the following segments are children. Recurse.
		let newNode = RBNode(element: sortedArray[middleIndex])
		newNode.isRed = false

		//make new array for the recursion
		let lowerArray = Array(sortedArray[0 ..< middleIndex])
		let upperArray = Array(sortedArray[middleIndex + 1 ..< endIndex])	

		newNode.leftChild = try self.insertFromSorted(lowerArray)
		newNode.rightChild = try self.insertFromSorted(upperArray)
		
		return newNode
	}

	func balanceTree() {
	//i didn't add this at first and relied on everything to be done at the node level, but I then realized that the color flipping on node level needs to be different on the tree root. children's color should be changed but not the root, which is always black. So I need to specify this on the tree level.

		if self.isEmpty == false {
			while self.root!.checkBalanced() == false {
			//do this until the black root is part of the balanced tree.

				self.root!.balanceTree()
				self.root!.isRed = false
			}
		}
	}

	func insert( element : T ) {
		if self.isEmpty {
			let newNode = RBNode(element: element)
			self.root = newNode
			self.root!.isRed = false
		}

		else {
			self.root!.insert(element : element)
		}

		self.balanceTree()

	}

	func checkBalanced() -> Bool {
		if self.isEmpty == false {
			return self.root!.checkBalanced()
		}
		else {
			return true
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

	func delete( element: T ) {
		//make tree an array, remove the element, then add the rest back to new tree.

		//not sure if this is valid though. this is like balancing the tree everytime something is deleted?
		var array = self.makeBreadthFirstArray()
		array = array.filter { $0 != element }
		let newBST = RedBlackTree()

		for node in array {
			newBST.insert(element: node)
		}

		self.root = newBST.root 
	}

}
