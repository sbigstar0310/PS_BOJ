// #2164

import Foundation
var N = Int(readLine()!)!

// DO IT!
solve()


func solve() {
    if N == 1 {
        print(1)
        return
    }
    var t = 1
    while (t < N) {
        t *= 2
    }

    let offset = N - t / 2
    
    print(2 * offset)
}
