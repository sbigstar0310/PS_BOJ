// #1799

import Foundation

let N = Int(readLine()!)!
var board = Array(repeating: Array(repeating: -1, count: N+1), count: N+1)

for index in 1...N {
    let line = readLine()!.split(separator: " ").map {Int($0)!}
    board[index] = [-1] + line
}

var upDiagonal: [Bool] = Array(repeating: false, count: 2 * N)
var downDiagonal: [Bool] = Array(repeating: false, count: 2 * N)


// DO IT!
solve()

var maxCntWhite = 0
var maxCntBlack = 0
func solve() {
    p(1, 1, 0, &maxCntWhite)
    p(1, 2, 0, &maxCntBlack)
    print(maxCntWhite + maxCntBlack)
}

func p(_ x: Int, _ y: Int, _ depth: Int, _ maxCnt: inout Int) {
    
    var nX = x
    var nY = y
    
    if nY > N {
        nX += 1
        if nY - 2 == N {
            nY = 1 + (N % 2)
        } else {
            nY = 2 - (N % 2)
        }
    }
    
    if nX > N {
        maxCnt = max(maxCnt, depth)
        return
    }
    
    let pair = (nX, nY)
    if vaild(pair) {
        let upDiagonalIndex = pair.0 + pair.1 - 1
        let downDiagonalIndex = N + (pair.1 - pair.0)
        upDiagonal[upDiagonalIndex] = true
        downDiagonal[downDiagonalIndex] = true
        p(nX, nY + 2, depth + 1, &maxCnt)
        upDiagonal[upDiagonalIndex] = false
        downDiagonal[downDiagonalIndex] = false
    }
    p(nX, nY + 2, depth, &maxCnt)
    
    
}

func vaild(_ pair: (Int, Int)) -> Bool {
    let udi = pair.0 + pair.1 - 1
    let ddi = N + (pair.1 - pair.0)
    
    return board[pair.0][pair.1] == 1 && !upDiagonal[udi] && !downDiagonal[ddi]
}


