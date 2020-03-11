//
//  DoublyLinkedList.swift
//  Cedric - Doubly Linked List
//  This is an exercise for the Data Structures class. Creating a doubly linked list class with multiple functionalities.
//  Created by Cedric on 3/10/20.
//  Copyright © 2020 Cedric Lam. All rights reserved.
//

import Foundation

class Node<T: Equatable> {
//set up the Node class and its value
    var value: T
    
    var nextNode: Node?
    var prevNode: Node? //previous nodes
    init(value: T, nextNode: Node? = nil, prevNode: Node? = nil) {
        self.value = value
        self.nextNode = nextNode
        self.prevNode = prevNode
    }

}

enum ListError: Error {
//create an error to be used later for when the index is larger than length
    case IndexOutOfBounds
}

class LinkedList<T: Equatable> {
    var head: Node<T>? = nil
    var tail: Node<T>? = nil
    
    var firstElement: T? {
        get {
        //Return first element
            return self.head?.value
        }
    }
    
    var lastElement: T? {
        get {
        //Return last element
            return self.tail?.value
        }
    }
    
    var length : Int {
    //calculate the length of the list
        get {
            
            //set up a counter and tracker variable
            var counter = 0
            var currentNode = self.head
            
            //loop until reaches nil, update counter and tracker
            while currentNode != nil {
                counter+=1
                currentNode = currentNode?.nextNode
            }
            
            return counter
        }
    }

    
    func insertAtHead( element: T ) {
    //insert a new node at head, next node is the old head
        let newNode = Node(value: element, nextNode: self.head)
        
        //update the head
        self.head?.prevNode = newNode
        self.head = newNode
        
        if self.tail == nil {
            //if new node replaces tail and list was blank
            self.tail = newNode
            
        }
    }

    
    func insertAtTail( element: T ){
    //set up a new node at tail
        let newNode = Node(value: element, prevNode: self.tail)
            
            //move tail to next node; update the tail
            self.tail?.nextNode = newNode
            self.tail = newNode
            
        if self.head == nil {
            //new node replaces head if list is blank
            self.head = newNode
        }
    }


    func removeFromHead(){
    //remove node from head
        if self.head?.nextNode == nil {
            //if there's only 1 element in the list, update the head and tail to nil (hence removing that only element)
            self.head = nil
            self.tail = nil
            
        } else {
            //if list isn't blank, move the head to the next node and the previous to nil
            self.head = self.head?.nextNode
            self.head?.prevNode = nil
        }
    }
    
    
    func removeFromTail() {
    //remove a node from the tail
        if self.head?.nextNode == nil {
            //if there's only 1 element in the list, update the head and tail to nil
            self.head = nil
            self.tail = nil
            
        } else {
            self.tail?.prevNode?.nextNode = nil
            self.tail = self.tail?.prevNode
        }
    }

    
    func toArray() -> [T] {
    //turn the Linked List to an array
        //declare blank array and node to append to the array
        var myArray: [T] = []
        var nodeToAppend = self.head
        
        // if the node isn't nil (not after tail), append it to the array then jump to the next node
        while nodeToAppend != nil {
            myArray.append(nodeToAppend!.value)
            nodeToAppend = nodeToAppend?.nextNode
        }
        
        return myArray
    }
    
    
    func insertAt(index: Int, element : T) throws {
    //insert a node at a given index value
        //create a current node tracker
        var currentNode = self.head
        
        //if index is larger than length, throw out an error.
        guard index <= self.length || index < 0 else {
            throw ListError.IndexOutOfBounds
        }

        //if index is at 0, use insertAtHead function
        if index == 0 {
                self.insertAtHead(element: element)
            
        //if user wants to insert at tail, use that function
        } else if index == self.length {
            self.insertAtTail(element: element)
            
        //if not all of the above. find the note at index value + update it. Do the same for the node after, and its previous node
        } else {
            for _ in 0..<index-1 {
                currentNode = currentNode?.nextNode
            }
            
            let newNode = Node(value: element, nextNode: currentNode?.nextNode,
                               prevNode: currentNode)
            currentNode?.nextNode?.prevNode = newNode
            currentNode?.nextNode = newNode
        }
    }
    
    
    func removeFrom( index : Int ) throws {
    //remove a note at a given index. declare current note tracker
        var currentNode = self.head
        
        //if index is larger than length, throw out an error
        guard index < self.length || index < 0 else {
            throw ListError.IndexOutOfBounds
        }
        
        if index == 0 {
            self.removeFromHead()
            
        } else if index == self.length - 1 {
            self.removeFromTail()
            
        } else {
            //similar to add at index, but update the next node of the current to the next next node, and that next next node's previous to the current!
            for _ in 0..<index-1 {
                currentNode = currentNode?.nextNode
            }
            currentNode?.nextNode?.nextNode?.prevNode = currentNode
            currentNode?.nextNode = currentNode?.nextNode?.nextNode
        }
    }
    
    
    func append(list : LinkedList) {
    //appends a linked list to an existing one
        
        if self.head == nil {
        //if old list is empty, old list becomes new list
            self.head = list.head
            self.tail = list.tail
            
        } else {
        //if not empty, change the pointers to its respective places
            self.tail?.nextNode = list.head
            list.head?.prevNode = self.tail
            
            if list.head != nil {
            //if the new list isn't blank, change the tail to the new list's tail (otherwise it stays at nil)
                self.tail = list.tail
            }
        }
    }
    
    
    func search( element : T) -> Int? {
    //finds first instance of element in list
        var currentNode = self.head
        var counter: Int? = 0
        
        //find values leading up to the one we're looking for to track the index (counter
        while currentNode?.value != element {
            counter!+=1
            currentNode = currentNode?.nextNode
            
            //if the counter runs through the list without finding any matching element, break the loop. make the counter nil.
            if counter == self.length {
                counter = nil
                break
            }
        }
        
        return counter
    }
    
    
    func searchForAll( element : T?) -> [Int] {
    //returns all indicies of the list that hold this element
        var myArray: [Int] = []
        var currentNode = self.head
        
        //if the head is the element, insert its index to the first position of array
        if self.head?.value == element {
            myArray.append(0)
            }
        
        //then append the rest of the indices that match the search key to the array
        for index in 1...self.length {
            currentNode = currentNode?.nextNode
            if currentNode?.value == element {
                myArray.append(index)
                }
            }

        return myArray
    }
}
