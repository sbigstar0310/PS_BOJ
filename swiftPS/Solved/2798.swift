// # 2798
import Foundation

let line = readLine()!.split(separator: " ").map {Int($0)!}
let (N, M) = (line[0], line[1])
let nums = readLine()!.split(separator: " ").map {Int($0)!}

// DO IT!
solve()

func solve() {
    var min = M
    var result = 0
    
    for i in nums.indices {
        for j in nums.indices {
            for k in nums.indices {
                if i != j, j != k, k != i  {
                    let sum = nums[i] + nums[j] + nums[k]
                    if (sum <= M) {
                        if (abs(M-sum) < min) {
                            min = abs(M-sum)
                        }
                    }
                }
            }
        }
    }
    
    print(M - min)
}
