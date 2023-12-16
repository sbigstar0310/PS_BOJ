// #2166

import Foundation
typealias Point = (Int, Int)

let N = Int(readLine()!)!
var points: [Point] = []

for _ in 1...N {
    let line = readLine()!.split(separator: " ").map {Int($0)!}
    points.append((line[0], line[1]))
}

// DO IT!
solve()

func solve() {
    var area = 0.0
    for index in 1 ..< (N-1) {
        area += AreaOfTriangle(points[0], points[index], points[index+1])
    }
    print(String(format: "%.1f", abs(area)))
}

func AreaOfTriangle(_ p1: Point, _ p2: Point, _ p3: Point) -> Double {
    return Double((p1.0 * p2.1 + p2.0 * p3.1 + p3.0 * p1.1) - (p2.0 * p1.1 + p3.0 * p2.1 + p1.0 * p3.1)) / 2
}
