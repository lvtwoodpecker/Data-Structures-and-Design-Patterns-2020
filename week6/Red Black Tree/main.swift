//Testing testing testing testing

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
print(tree.search(element: 103))
