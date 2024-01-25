// #4949

import Foundation

while true {
  var line = readLine()!
  if line.first == "." {
    break
  }
  _ = line.removeLast()
  
  let result = solve(arr: line)
  print(result)
}

//DO IT!
func solve(arr: String) -> String {
  var newString = arr.filter { c in
    return c == "[" || c == "]" || c == "(" || c == ")"
  }

  var queue: [Character] = []
  for c in newString {
    queue.append(c)
    
    if queue.count > 1 && isWellClosed(arr: queue) {
      queue.removeLast(2)
    }
  }

  if queue.isEmpty {
    return "yes"
  } else {
    return "no"
  }
}

func isWellClosed(arr: [Character]) -> Bool {
  return (arr[arr.count - 1] == "]" && arr[arr.count - 2] == "[") || arr[arr.count - 1] == ")" && arr[arr.count - 2] == "("
}
