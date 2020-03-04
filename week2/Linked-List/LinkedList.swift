//
//  LinkedList.swift
//  Cedric - Linked List
//  This is an exercise for the Data Structures class. Creating a linked list class with multiple functionalities.
//  Created by Cedric on 3/4/20.
//  Copyright © 2020 Cedric Lam. All rights reserved.
//

import Foundation

class Node {
//set up the Node class and its value
    var value: Int
    
    init(value: Int) {
        self.value = value
    }
    
    var nextNode: Node?
}

class LinkedList {
    var head: Node?
    var tail: Node?
    
    var firstElement: Int? {
        get {
        //Return first element
            return self.head?.value
        }
    }
    
    var lastElement: Int? {
        get {
        //Return last element
            return self.tail?.value
        }
    }
    
    var length : Int {
    //calculate the length of the list
        get {
            
            //set up a counter
            var counter = 0
            
            //variable to track progress through LinkedList and set to head
            var currentNode = self.head
            
            //loop until reaches nil, update counter and tracker
            while currentNode != nil {
                counter+=1
                currentNode = currentNode?.nextNode
            }
            
            //return the counter
            return counter
        }
    }

    
    func insertAtHead( element: Int ) {
    //insert a new node at head
        let newNode = Node(value: element)
        
        if self.head == nil {
            
            //new node replaces tail and head if list is blank
            self.tail = newNode
            self.head = newNode
            self.head?.nextNode = nil
            self.tail?.nextNode = nil
            
        } else {

            //if not blank, move the head to next node; update the head
            newNode.nextNode = self.head
            self.head = newNode
            
        }
    }

    
    func insertAtTail( element: Int ){
    //set up a new node at tail -> the next node will be nil
        let newNode = Node(value: element)
        newNode.nextNode = nil
        
        if self.head == nil {
            //new node replaces tail and head if list is blank
            self.tail = newNode
            self.head = newNode
            
        } else {
            //if not blank, move tail to next node; update the tail
            self.tail?.nextNode = newNode
            self.tail = newNode
            }
    }


    func removeFromHead(){
    //remove node from head
        if self.head?.nextNode == nil {
            //if there's only 1 element in the list, update the head and tail to nil (hence removing that only element)
            self.head = nil
            self.tail = nil
            
        } else {
            //if list isn't blank, move the head to the next node
            self.head = self.head?.nextNode
        }
    }
    
    func removeFromTail() {
    //remove a node from the tail
        if self.head?.nextNode == nil {
            //if there's only 1 element in the list, update the head and tail to nil
            self.head = nil
            self.tail = nil
            
        } else {
            //set up variable to track current node
            var currentNode = self.head
            
            // if the node after the next isn't nil, move the node along
            while currentNode?.nextNode?.nextNode != nil {
                currentNode = currentNode?.nextNode
            }
            
            // when next to the tail, make the tail nil; update tail to current node
            currentNode?.nextNode = nil
            self.tail = currentNode
        }
    }

    func toArray() -> [Int] {
    //turn the Linked List to an array
        //declare blank array and node to append to the array
        var myArray: [Int] = []
        var nodeToAppend = self.head
        
        // if the node isn't nil (not after tail), append it to the array then jump to the next node
        while nodeToAppend != nil {
            myArray.append(nodeToAppend!.value)
            nodeToAppend = nodeToAppend?.nextNode
        }
        
        return myArray
    }
    
    func insertAt(index: Int, element : Int) {
    //insert a node at a given index value
        //declare new node and create a current node tracker
        let newNode = Node(value: element)
        var currentNode = self.head
        
        if index > self.length {
            //error prompt for index outside size of list. I don't quite understand how to add errors properly so let's just use this
            print("Error!! Linked list currently isn't long enough to have that index")
            
            //if index is at 0, use insertAtHead function
        } else if index == 0 {
                self.insertAtHead(element: element)
            
            //if user wants to insert at tail, use that function
        } else if index == self.length {
            self.insertAtTail(element: element)
            
            //if not all of the above. find the note at index value and update it and the node after accordingly
        } else {
            for _ in 0..<index-1 {
                currentNode = currentNode?.nextNode
            }
            newNode.nextNode = currentNode?.nextNode
            currentNode?.nextNode = newNode
        }
    }
    
    func removeFrom( index : Int ) {
    //remove a note at a given index. declare current note tracker
        var currentNode = self.head
        if index == 0 {
            self.removeFromHead()
            
        } else if index >= self.length {
            print("Error!! Linked list currently isn't long enough to have that index")
            
        } else if index == self.length - 1 {
            self.removeFromTail()
            
        } else {
            //similar to add at index, but update the next node of the current to the next next node
            for _ in 0..<index-1 {
                currentNode = currentNode?.nextNode
            }
            currentNode?.nextNode = currentNode?.nextNode?.nextNode
        }
    }
    
    func append(list : LinkedList) {
    // append a linked list to an existing one
        
        if self.head == nil {
            //if the list is blank then just copy the other list
            self.head = list.head
            self.tail = list.tail
            
        } else {
            //make the tracking node the head of the list. insert that node's value to the tail of the existing list. then update the tracking node to the next. it runs through the length of the new list
            for _ in 0...list.length - 1 {
                var currentNode = list.head
                self.insertAtTail(element: currentNode!.value)
                
                currentNode = currentNode?.nextNode
                list.head = currentNode
            }
        }
    }
    // This should also work for append but doesn't? I'm not sure what the problem is here! but this would reduce the runtime a lot!
    //
    //      self.tail?.nextNode?.value = list.head
    //      self.tail = list.tail
    //      self.tail?.nextNode = nil
    //
    
    
    func search( element : Int) -> Int? {
    //finds first instance of element in list
        var currentNode = self.head
        var counter: Int? = 0
        
        //find values leading up to the one we're looking for to track the index (counter
        while currentNode?.value != element {
            counter!+=1
            currentNode = currentNode?.nextNode
            
            //if the counter runs through the list without finding any matching element, break the loop. make the counter nil.
            if counter! == self.length {
                counter = nil
                break
            }
        }
        
        return counter
    }
    
    func searchForAll( element : Int) -> [Int] {
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
