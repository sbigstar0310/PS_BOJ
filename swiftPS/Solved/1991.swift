// #1991
import Foundation

class Node {
    let data: String
    var leftChild: Node?
    var rightChild: Node?
    
    init(_ data: String) {
        self.data = data
    }
}

struct Tree {
    var rootNode: Node? = nil
    
    init(_ rootNode: Node) {
        self.rootNode = rootNode
    }
    
    func find( _ node: Node?, _ val: String) -> Node? {
        guard let rn = node else {return nil}
        if rn.data == val {
            return rn
        }
        else {
            let result1 = find(rn.leftChild, val)
            let result2 = find(rn.rightChild, val)
            
            if result1 != nil {
                return result1
            }
            else if result2 != nil {
                return result2
            }
            else {
                return nil
            }
        }
    }
    
    func preorderTraverse(_ node: Node) {
        // 전위 순회
        print(node.data, terminator: "")
        if  node.leftChild != nil {
            preorderTraverse(node.leftChild!)
        }
        if  node.rightChild != nil {
            preorderTraverse(node.rightChild!)
        }
    }
    
    func inorderTraverse(_ node: Node) {
        // 중위 순회
        if  node.leftChild != nil {
            inorderTraverse(node.leftChild!)
        }
        print(node.data, terminator: "")
        if  node.rightChild != nil {
            inorderTraverse(node.rightChild!)
        }
    }
    
    func postorderTraverse(_ node: Node) {
        // 후위 순회
        if  node.leftChild != nil {
            postorderTraverse(node.leftChild!)
        }
        if  node.rightChild != nil {
            postorderTraverse(node.rightChild!)
        }
        print(node.data, terminator: "")
    }
}

var N = Int(readLine()!)!

let rootNode = Node("A")
var tree: Tree = Tree(rootNode)

for _ in 1...N {
    let line = readLine()!.split(separator: " ")
    
    guard let rn = tree.find(rootNode, String(line[0])) else {
        continue
    }
    
    let lc: Node = Node(String(line[1]))
    let rc: Node = Node(String(line[2]))
    
    if lc.data != "." {
        rn.leftChild = lc
    }
    if rc.data != "." {
        rn.rightChild = rc
    }
}

tree.preorderTraverse(rootNode)
print()
tree.inorderTraverse(rootNode)
print()
tree.postorderTraverse(rootNode)
print()
