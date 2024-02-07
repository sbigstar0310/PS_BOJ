// #11659

import Foundation

struct Point: Hashable {
  var start: Int
  var end: Int
}

let line = readLine()!.split(separator: " ").map {Int($0)!}
let (N, M) = (line[0], line[1])
let numbers = [0] + readLine()!.split(separator: " ").map {Int($0)!}
var points: [Point] = []
for _ in 1...M {
  let line = readLine()!.split(separator: " ").map {Int($0)!}
  points.append(Point(start: line[0], end: line[1]))
}

//DO IT!
solve()

func solve() {
  var prefixSum: [Int] = []
  var results: [Int] = []
  var currentSum = 0
  for num in numbers {
    currentSum += num
    prefixSum.append(currentSum)
  }
  
  for point in points {
    results.append(prefixSum[point.end] - prefixSum[point.start - 1])
  }
  
  for r in results {
    print(r)
  }
}

