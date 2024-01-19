// #1005

import Foundation

final class FileIO {
    private var buffer:[UInt8]
    private var index: Int
    
    init(fileHandle: FileHandle = FileHandle.standardInput) {
        buffer = Array(fileHandle.readDataToEndOfFile())+[UInt8(0)] // 인덱스 범위 넘어가는 것 방지
        index = 0
    }
    
    @inline(__always) private func read() -> UInt8 {
        defer { index += 1 }
        
        return buffer.withUnsafeBufferPointer { $0[index] }
    }
    
    @inline(__always) func readInt() -> Int {
        var sum = 0
        var now = read()
        var isPositive = true
        
        while now == 10
                || now == 32 { now = read() } // 공백과 줄바꿈 무시
        if now == 45{ isPositive.toggle(); now = read() } // 음수 처리
        while now >= 48, now <= 57 {
            sum = sum * 10 + Int(now-48)
            now = read()
        }
        
        return sum * (isPositive ? 1:-1)
    }
    
    @inline(__always) func readString() -> String {
        var str = ""
        var now = read()
        
        while now == 10
                || now == 32 { now = read() } // 공백과 줄바꿈 무시
        
        while now != 10
                && now != 32 && now != 0 {
            str += String(bytes: [now], encoding: .ascii)!
            now = read()
        }
        
        return str
    }
}

// example
let fIO = FileIO()

let T = fIO.readInt()
var result = ""

for _ in 1...T {
    let (N, K) = (fIO.readInt(), fIO.readInt())
    var times = [0]
    for _ in 0..<N {
        times.append(fIO.readInt())
    }
    var graph: [[Int]] = Array(repeating: [], count: N+1)
    for _ in 1...K {
        let (s, e) = (fIO.readInt(), fIO.readInt())
        graph[e].append(s)
    }
    let W = fIO.readInt()
    var memo: [Int: Int] = [:]
    
    
    // DO IT!
    solve()
    
    func solve() {
        let maxTime = DFS(node: W)
        result += "\(maxTime)\n"
    }
    
    func DFS(node: Int) -> Int {
        if let time = memo[node] {
            return time
        }
        var maxTime = times[node]
        for adj in graph[node] {
            maxTime = max(maxTime, DFS(node: adj) + times[node])
        }
        memo[node] = maxTime
        return maxTime
    }
}

print(result)
