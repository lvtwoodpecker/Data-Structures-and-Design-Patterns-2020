//
//  HomeworkFunctions.swift
//  Cedric - Stack and Queue
//  This is an exercise for the Data Structures class. Solve some problems here!
//  Created by Cedric on 3/23/20.
//  Copyright © 2020 Cedric Lam. All rights reserved.
//

import Foundation

func hasCorrectDelimiters(_ input: String ) -> Bool {
  //checks to see if a string has correct delimiter inputs

  //convert string input into an array of strings so that it's easier to work with
  let CharacterArray = input.map({String($0)})

  //create a dictionary of delimiters, opening and closing delimters are keys and values
  let delimiters = ["(": ")", "[": "]", "{": "}"]

  //create a blank stack to add the delimiters in later
  let stack = Stack<String>()

  for character in CharacterArray {

    //remember the top of the stack
    let StackTop = stack.peek()

    if delimiters.keys.contains(character) {
      stack.push(element: character)
    }


    //if the character is the closing delimiter, pop the opening delimiter out of the stack. match keys and values for this
    //logic: 2 opposing delimiters in a row on the array cancel each other out

    else if StackTop == "(" && character == ")" {
			_ = stack.pop()
		}

		else if StackTop == "[" && character == "]" {
			_ = stack.pop()
		}

		else if StackTop == "{" && character == "}" {
			_ = stack.pop()
		}

    // trying to figure this out. I want to do a a key-value dictionary to minimize the lines of code above but still strying to figure that out.
    // else if character == delimiters[StackTop] {
    //   _ = stack.pop()!
    // }

    else if delimiters.values.contains(character) {

			if stack.isEmpty {
				stack.push(element: character)
      }
      else{
        break
      } 
    }
  }
  
  return stack.isEmpty
}

func isAPalindrome(_ input: String ) -> Bool {
  //check to see if string is a palindrome
  //this one is case sensitive and special character sensitive!
  let CharracterList = "abcdefghijklmnopqrstuvwxyz"

  //convert string input and character list into an array
  let ApprovedLetters = Array(CharracterList)
  
  //create blank stack and queue
  let stack = Stack<Character>()
  let queue = Queue<Character>()

  //add all elements into a stack
  for character in input.lowercased() {
    if ApprovedLetters.contains(character){
      stack.push(element: character)
    }
  }

  //add all elements into a queue
  for character in input.lowercased() {
    if ApprovedLetters.contains(character){
    queue.enqueue(element: character)
    }
  }

  if stack.stack == queue.queue {
    return true
  }
  else {
    return false
  }
}