//
//  Stacks and Queues.swift
//  Cedric - Stack and Queue
//  This is an exercise for the Data Structures class. Creating a stack and a queue class with multiple functionalities + solve problems
//  Created by Cedric on 3/23/20.
//  Copyright © 2020 Cedric Lam. All rights reserved.
//

import Foundation

class Stack<T: Equatable> {
    //make an array to hold the elements. this is called... stack
    var stack: [T]

    init(stack: [T] = []) {
      self.stack = stack
    }

    var size : Int {
      //calculates the size of stack

      return self.stack.count
    }

    var isEmpty : Bool {
      //checks to see if empty

      return stack.isEmpty
    }

    func push( element: T ){
      //add an element to the top of the stack (which is last of the array)

      self.stack.insert(element, at: 0)
    }

    func pop() -> T? {
      //returns and removes the top element of the stack

      let firstElement = self.stack.first
      
      if !self.stack.isEmpty {
        self.stack.removeFirst()
      }
      return firstElement
    }

    func peek() -> T? {
      //returns the top element of the stack
      return self.stack.first
    }

    func clear() {
      //clears the stack

      self.stack = []
    }
}

class Queue<T: Equatable> {
    //make an array to hold the elements.
    var queue: [T]

    init(queue: [T] = []) {
      self.queue = queue
    }

    var size : Int {
    //calculates the size of stack

      return self.queue.count
    }

    var isEmpty : Bool {
    //checks to see if empty

      return queue.isEmpty
    }

    func enqueue( element: T ){
      //add an element to the end of the queue

      self.queue.append(element)
    }

    func dequeue() -> T? {
      //returns and removes the first element of the queue

      let firstElement = self.queue.first
      if !self.queue.isEmpty {
        self.queue.removeFirst()
      }

      return firstElement
    }

    func front() -> T? {
      //returns the top element of the stack

      return self.queue.first
    }

    func clear() {
      //clears the queue

      self.queue = []
    }
}