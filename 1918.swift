// #1918
import Foundation

class Node {
    var data: String?
    
    var leftChild: Node?
    var rightChild: Node?
    
    init(data: String? = nil) {
        self.data = data
    }
}

struct Tree {
    var rootNode: Node?
}

var line = readLine()!

// DO IT!
solve()


func solve() {
    let tree:Tree = makeTree(line)
    printTree(tree.rootNode!)
    print()
}

func makeTree(_ string: String) -> Tree {
    // 우선 순위가 가장 낮은 연산자를 기준으로 좌측 subtree와 우측 subtree로 나눈다.
    var newString = string
    while newString[newString.startIndex] == "(" || newString[newString.index(before: newString.endIndex)] == ")" {
        if newString[newString.startIndex] == "(" {
            newString.remove(at: newString.startIndex)
        }
        if newString[newString.index(before: newString.endIndex)] == ")" {
            newString.remove(at: newString.index(before: newString.endIndex))
        }
    }
    var resultTree: Tree = Tree()
    if newString.count == 1 {
        let rootNode: Node = Node(data: newString)
        resultTree.rootNode = rootNode
        return resultTree
    }
    
    let minPriorityIndex = getMinPriorityIndex(newString)
    let rootNode: Node = Node(data: String(newString[minPriorityIndex]))
    let leftString = newString[..<minPriorityIndex]
    rootNode.leftChild = makeTree(String(leftString)).rootNode
    let rightString = newString[newString.index(after: minPriorityIndex)...]
    rootNode.rightChild = makeTree(String(rightString)).rootNode
    
    resultTree.rootNode = rootNode
    return resultTree
}

func printTree(_ rootNode: Node) {
    let rn = rootNode
    let lc = rn.leftChild
    let rc = rn.rightChild
    if lc != nil {
        printTree(lc!)
    }
    if rc != nil {
        printTree(rc!)
    }
    print(rn.data!, terminator: "")
}

func getMinPriorityIndex(_ string: String) -> String.Index {
    var resultIndex = string.startIndex
    
    var memo: [(Int, Int)] = []
    var priority = 0
    var index = 0
    
    for c in string {
        if c == "(" {
            priority += 100 * 100
        }
        else if c == ")" {
            priority -= 100 * 100
        }
        else if c == "*" || c == "/" {
            priority += 100
            memo.append((priority, index))
            priority -= 100
        }
        else if c == "+" || c == "-" {
            memo.append((priority, index))
        }
        index += 1
        priority -= 1
    }
    
    memo.sort(by: <)
    resultIndex = string.index(string.startIndex, offsetBy: memo[0].1)
    return resultIndex
}
