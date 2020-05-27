//test

let graph = Graph<Int>(vertices: 5)
graph.addEdge(firstVertex: 1, secondVertex: 2)
graph.addEdge(firstVertex: 0, secondVertex: 1)
graph.addEdge(firstVertex: 3, secondVertex: 0)
graph.addEdge(firstVertex: 4, secondVertex: 2)
// graph.addEdge(firstVertex: 4, secondVertex: 1)
// graph.addEdge(firstVertex: 2, secondVertex: 0)
graph.addEdge(firstVertex: 3, secondVertex: 4)


print(graph.vertexArray)

print(graph.neighborsOf( vertex : 1))
print(graph.neighborsOf( vertex : 2))

print(graph.verticesAreAdjacent(firstVertex: 2, secondVertex: 1))

print(graph.breadthFirstSearch(0))
print(graph.shortestPathFrom(1, to: 4))
print(graph.hasCycle())
