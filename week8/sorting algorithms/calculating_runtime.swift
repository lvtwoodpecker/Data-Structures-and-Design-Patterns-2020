//
// Companion file to test out the runtime of each algo
//
//
import Foundation

extension Date {
    var microsecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000000.0))
    }
}

func AverageTimeHeap(_ array: [Int]) -> Double {
	//in seconds
	var totalTime : Int64 = 0
	for _ in 0..<100 {
		let start = Date().microsecondsSince1970
		array.heapSort()
		let end = Date().microsecondsSince1970 - start
		totalTime += end
	}

	return 	Double(totalTime) / 5 / 1000000
}

// Take a function as a parameter, then execute that said function inside the average time function so that I won't need to repeat code.

func AverageTimeBubble(_ array: [Int]) -> Double {
	//in seconds
	var totalTime : Int64 = 0
	for _ in 0..<100 {
		let start = Date().microsecondsSince1970
		array.bubbleSort()
		let end = Date().microsecondsSince1970 - start
		totalTime += end
	}

	return 	Double(totalTime) / 5 / 1000000
}

func AverageTimeInsertion(_ array: [Int]) -> Double {
	//in seconds
	var totalTime : Int64 = 0
	for _ in 0..<100 {
		let start = Date().microsecondsSince1970
		array.insertionSort()
		let end = Date().microsecondsSince1970 - start
		totalTime += end
	}

	return 	Double(totalTime) / 5 / 1000000
}

func AverageTimeSelection(_ array: [Int]) -> Double {
	//in seconds
	var totalTime : Int64 = 0
	for _ in 0..<100 {
		let start = Date().microsecondsSince1970
		array.selectionSort()
		let end = Date().microsecondsSince1970 - start
		totalTime += end
	}

	return 	Double(totalTime) / 5 / 1000000
}
