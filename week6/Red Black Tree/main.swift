//
//  main.swift
//  Cedric - Red Black Tree
//  This is an exercise for the Data Structures class. Implement a Red Black Tree, which is a binary search tree but optimized?
//  Created by Cedric on 4/11/20.
//  Copyright © 2020 Cedric Lam. All rights reserved.

// Driver file
let tree = RedBlackTree<Int>()
tree.insert(element: 4)
tree.insert(element: 7)
tree.insert(element: 1)
tree.insert(element: 8)
tree.insert(element: 3)
tree.insert(element: 6)
tree.insert(element: 10)
tree.insert(element: 2)
tree.insert(element: 9)
tree.insert(element: 5)

print(tree.makeBreadthFirstArray())
print(tree.checkBalanced())
print("Height:", tree.height)

print("Ordered:", tree.elements)
print("Size:", tree.size)
print(tree.contains(element: 2))

tree.delete(element: 4)
print("After deleting 4", tree.makeBreadthFirstArray())
print("Ordered:", tree.elements)
print("Size:", tree.size)
print("Height:", tree.height)
print(tree.checkBalanced())


let tree2 = RedBlackTree<Int>(fromSortedData : [1,2,3,4,5,6,7,8,9,10])
print("Tree 2:", tree2.makeBreadthFirstArray())
print("Ordered:", tree2.elements)
print("Size:", tree2.size)
print("Height:", tree2.height)
print(tree2.checkBalanced())

tree2.insert(element: 100)
tree2.insert(element: 1100)
tree2.insert(element: 1200)

print("Tree 2:", tree2.makeBreadthFirstArray())
print(tree2.checkBalanced())

tree2.delete(element:1200)
print("Tree 2:", tree2.makeBreadthFirstArray())
print("After deleting 1200", tree2.makeBreadthFirstArray())
print("Ordered:", tree2.elements)
print("Size:", tree2.size)
print("Height:", tree2.height)
print(tree2.checkBalanced())
