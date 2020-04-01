//
//  main.swift
//  Cedric - Stack and Queue
//  This is an exercise for the Data Structures class. Creating a stack and a queue class with multiple functionalities + solve problems
//  Created by Cedric on 3/23/20.
//  Copyright © 2020 Cedric Lam. All rights reserved.
//
import Foundation

func StackTest() {
	let stack = Stack(stack: [13333, 012, 3214])
	stack.push(element: 10000000)
	print(stack.stack)

	print("\(stack.pop()!) died")
  print(stack.isEmpty)
	
	print(stack.peek()!)
	stack.clear()
	print(stack.stack)
}

func QueueTest() {
	let queue = Queue(queue: ["s", "aa", "aasoqSS"])
	queue.enqueue(element: "@@")
	print(queue.queue)

	print("\(queue.dequeue()!) died")
	print(queue.front()!)
  print(queue.isEmpty)

	queue.clear()
	print(queue.queue)

}

func delimiterTest() {
	let test = "{(((([[{{{[]}}}]]))))}"
	let result = hasCorrectDelimiters(test)
  print(result)
}

func palindromeTest() {
	let test = "Mr. Owl ate my metal worm"
	let result = isAPalindrome(test)
  print(result)
}

func main() {
	
	StackTest()
	print()
	QueueTest()

	print()
	print("test this: {(((([[{{{[]}}}]]))))}")
  delimiterTest()

  print()
	print("test this: 'Mr. Owl ate my metal worm'")
	palindromeTest()
}

main()