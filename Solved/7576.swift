// #7576
import Foundation

struct Point: Hashable {
  var x: Int
  var y: Int
}

let line = readLine()!.split(separator: " ").map {Int($0)!}
let (M, N) = (line[0], line[1])
var table: [[Int]] = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)
var zeroCnt = 0

for n in 0..<N {
  let line = readLine()!.split(separator: " ").map {Int($0)!}
  table[n] = line
  
  for num in line {
    if num == 0 {
      zeroCnt += 1
    }
  }
}

//DO IT!
solve()

func solve() {
  var currentTomatoPoints = [Point]()
  var minDay = 0
  
  for y in 0..<N {
    for x in 0..<M {
      if table[y][x] == 1 {
        currentTomatoPoints.append(Point(x: x, y: y))
      }
    }
  }
  
  while zeroCnt > 0 {
//    printTable()
    var newCurrentTomatoPoints = [Point]()
    
    for ctPoint in currentTomatoPoints {
      newCurrentTomatoPoints.append(contentsOf: spreadTomato(ctPoint, &table))
    }
    zeroCnt -= newCurrentTomatoPoints.count
    currentTomatoPoints = newCurrentTomatoPoints
    
    // If zeroCnt is not changed -> infinite loop
    if currentTomatoPoints.isEmpty {
      print(-1)
      return
    }
    
    minDay += 1
  }
  
  print(minDay)
}

func spreadTomato(_ point: Point, _ table: inout [[Int]]) -> [Point] {
  let xDirection = [-1, 1, 0, 0]
  let yDirection = [0, 0, -1, 1]
  var newCurrentTomatoPoints = [Point]()
  
  for index in 0..<4 {
    let newX = point.x + xDirection[index]
    let newY = point.y + yDirection[index]
    if isValid(newX, newY) && table[newY][newX] == 0 {
      table[newY][newX] = 1
      newCurrentTomatoPoints.append(Point(x: newX, y: newY))
    }
  }
  
  return newCurrentTomatoPoints
}


func isValid(_ x: Int, _ y: Int) -> Bool {
  return 0 <= x && x < M && 0 <= y && y < N
}

func printTable() {
  print("---------------")
  for y in 0..<N {
    for x in 0..<M {
      print(table[y][x], terminator: " ")
    }
    print()
  }
  print("---------------")
}
