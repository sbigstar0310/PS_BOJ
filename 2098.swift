// #2098

import Foundation

let N = Int(readLine()!)!
var graph: [[(Int, Int)]] = Array(repeating: [], count: N)
let maxBit: Int = (1 << N)
var dp: [[[Int]]] = Array(repeating: Array(repeating: Array(repeating: 16 * 1000000, count: maxBit), count: N), count: N)

for index in 0..<N {
    let line = readLine()!.split(separator: " ").map {Int($0)!}
    for (i, cost) in line.enumerated() {
        graph[index].append((i, cost))
    }
}

//DO IT!
solve()

func solve() {
    // 시작 노드는 0.
    // 0의 인접 노드들에 대해서 dp 값 갱신. (단, 0 -> 0 과 cost가 0인 곳 제외)
    for (adj, cost) in graph[0]  where adj != 0 && cost != 0 {
        dp[0][adj][1 | (1 << adj)] = cost
    }
    
    // 현재 노드에 대한 인접 노드들에 대해서, 만약 인접 노드를 방문하는 것이 더 최소라면 dp값을 갱신.
    // 중복되는 지점에 대해서는 더 최소값을 선택하도록 한다.
    // -: 예. min(1 -> 4 -> 2 -> 3 , 1 -> 2 -> 4 -> 3)
    // 한번 방문한 노드는 더 이상 방문 할 수 없다.
    // -: 현재까지 방문한 노드들(bit)에 대해서 새 노드 adj가 없는 경우에만 갱신한다.
    // -: bit & (adj << 1) == 0
    // -: 예. (1101) & (0010) == 0
    for step in 0..<(N-1){
        for curNode in 0..<N {
            for bit in 0..<maxBit {
                for (adj, cost) in graph[curNode] where dp[step][curNode][bit] != 16000000 && cost != 0 {
                    if (bit & (1 << adj)) == 0 // 방문 X 경우
                    {
                        dp[step+1][adj][bit | (1 << adj)] = min(dp[step+1][adj][bit | (1 << adj)], dp[step][curNode][bit] + cost)
                    }
                }
                
                // 마지막 step, 모든 노드에서 -> 0으로 다시 돌아오는 값 갱신
                if step == N - 2 {
                    for (adj, cost) in graph[curNode] where dp[step][curNode][bit] != 16000000 && cost != 0 {
                        dp[step+1][adj][bit | (1 << adj)] = min(dp[step+1][adj][bit | (1 << adj)], dp[step][curNode][bit] + cost)
                        
                    }
                }
            }
        }
    }
    
    print(dp[N-1][0][maxBit-1])
}
