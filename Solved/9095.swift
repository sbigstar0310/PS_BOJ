// #9095

import Foundation

let T = Int(readLine()!)!
var results = [Int]()

for _ in 1...T {
  let n = Int(readLine()!)!
  
  //DO IT
  solve(n)
}

for r in results {
  print(r)
}

func solve(_ n: Int) {
  let result: Set<String> = rec(n)
  results.append(result.count)
}

func rec(_ n: Int) -> Set<String> {
  if n == 0 {
    return []
  } else if n == 1 {
    return ["1"]
  } else if n == 2 {
    return ["11", "2"]
  } else if n == 3 {
    return ["111", "12", "21", "3"]
  } else {
    return setMap(String: "1", set: rec(n - 1)).union(setMap(String: "2", set: rec(n - 2))).union(setMap(String: "3", set: rec(n - 3)))
  }
}

func setMap(String s: String, set: Set<String>) -> Set<String> {
  var result: Set<String> = []
  
  for e in set {
    result.insert(s + e)
  }
  return result
}
