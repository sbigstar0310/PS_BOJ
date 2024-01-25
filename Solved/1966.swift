// #1966

import Foundation

let T = Int(readLine()!)!
var results: [Int] = []

for _ in 1...T {
  let line = readLine()!.split(separator: " ").map {Int($0)!}
  let (N, index) = (line[0], line[1])
  var documents: [Int] = readLine()!.split(separator: " ").map {Int($0)!}
  
  //DO IT
  solve()
  
  func solve() {
    var tracingIndex = index
    var resultCnt = 0
    
    while !documents.isEmpty {
      let q = documents.removeFirst()
      tracingIndex -= 1
      
      if q >= documents.max() ?? 0 {
        resultCnt += 1
        if tracingIndex == -1 {
          results.append(resultCnt)
          break
        }
      } else {
        documents.append(q)
        if tracingIndex == -1 {
          tracingIndex = documents.count - 1
        }
      }
    }
  }
}

for r in results {
  print(r)
}
