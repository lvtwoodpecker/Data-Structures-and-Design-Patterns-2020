// try
let a = RedBlackTree<String>()
a.insert(element: "A")
a.insert(element: "B")
a.insert(element: "CCCC")
a.insert(element: "CCDC")
a.insert(element: "ACC")
a.insert(element: "5")

print(a.elements)
print(a.height)
print(a.size)

let Tree = RedBlackTree<String>(fromSortedData: ["a", "A", "pdocaxca", "ASSACCVWR)OB", "hhhhh", "F", "ew"])

print(Tree.elements)
print(Tree.height)
print(Tree.size)
print(Tree.makeBreadthFirstArray())
print(Tree.contains(element: "f"))
print(Tree.search(element: "F"))
