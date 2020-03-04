//
//  main.swift
//  Cedric - Linked List
//  This is an exercise for the Data Structures class. Creating a linked list class with multiple functionalities. Main file
//  Created by Cedric on 3/3/20.
//  Copyright © 2020 Cedric Lam. All rights reserved.
//

import Foundation


let myList = LinkedList()
myList.insertAtHead(element: 12)
myList.insertAtHead(element: 12)
myList.insertAtHead(element: 1)
    
myList.insertAtTail(element: 1)
myList.insertAtTail(element: 2)
myList.insertAtTail(element: 12)
    
myList.insertAt(index: 4, element: 11)
myList.removeFrom(index: 2)
    
print("Here's your list:", myList.toArray())
print("Your first node is", myList.firstElement!)
print("Your last node is", myList.lastElement!)
print("Your list has", myList.length, "nodes")

print("Index of number 11 in the list:", String(describing: myList.search(element: 11)!))
    
print("Here's a list of indices in this goddamn list:", myList.searchForAll(element: 2))

let newList = LinkedList()
newList.append(list: myList)
newList.insertAtHead(element: 11)
    
myList.append(list: newList)
print("Your new list:", myList.toArray())
