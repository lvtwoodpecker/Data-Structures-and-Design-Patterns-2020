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
    
do{
try myList.insertAt(index: 7, element: 11)
} catch let error {
    print("Error: \(error)")
}

do{
try myList.removeFrom(index: 6)
} catch let error {
    print("Error: \(error)")
}
    
print("Here's your list:", myList.toArray())
//print("Your first node is", myList.firstElement!)
//print("Your last node is", myList.lastElement!)
//print("Your list has", myList.length, "nodes")
//
//print("Index of number 11 in the list:", String(describing: myList.search(element: 11)))
//
//print("Here's a list of indices in this goddamn list:", myList.searchForAll(element: 2))

let newList = LinkedList()
//newList.insertAtHead(element: 11)
//newList.insertAtHead(element: 13)
//newList.insertAtHead(element: 10)
print(newList.toArray())
    
myList.append(list: newList)
print("Your new list:", myList.toArray())
