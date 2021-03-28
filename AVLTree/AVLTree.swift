//
//  AVLTree.swift
//  AVLTree
//
//  Created by Oleksiy on 28.03.2021.
//

import Foundation

class AVLTree<T:Comparable> {
    
    private typealias Node = TreeNode<T>
    
    private var root: Node?
    private(set) var size = 0
    
    //MARK: - Insert
    public func insert(key: T) {
        if let root = root {
            insert(input: key, node: root)
        } else {
            root = Node(key: key)
        }
        size += 1
    }
    
    private func insert(input: T, node: Node) {
        if input < node.data {
            if let child = node.leftChild {
                insert(input: input, node: child)
            } else {
                let child = Node(key: input, leftChild: nil, rightChild: nil, parent: node, height: 1)
                node.leftChild = child
                balance(node: child)
            }
        } else {
            if let child = node.rightChild {
                insert(input: input, node: child)
            } else {
                let child = Node(key: input, leftChild: nil, rightChild: nil, parent: node, height: 1)
                node.rightChild = child
                balance(node: child)
            }
        }
    }
    
    //MARK: - Balancing
    private func updateHeightUpwards(node: Node?) {
        if let node = node {
            let lHeight = node.leftChild?.height ?? 0
            let rHeight = node.rightChild?.height ?? 0
            node.height = max(lHeight, rHeight) + 1
            updateHeightUpwards(node: node.parent)
        }
    }
    
    private func heightDifference(node: Node?) -> Int {
        let lHeight = node?.leftChild?.height ?? 0
        let rHeight = node?.rightChild?.height ?? 0
        return lHeight - rHeight
    }
    
    private func balance(node: Node?) {
        guard let node = node else {
            return
        }
        
        updateHeightUpwards(node: node.leftChild)
        updateHeightUpwards(node: node.rightChild)
        
        var nodes = [Node?](repeating: nil, count: 3)
        var subtrees = [Node?](repeating: nil, count: 4)
        let nodeParent = node.parent
        
        let lrFactor = heightDifference(node: node)
        if lrFactor > 1 {
            // left-left or left-right
            if heightDifference(node: node.leftChild) > 0 {
                // left-left
                nodes[0] = node
                nodes[2] = node.leftChild
                nodes[1] = nodes[2]?.leftChild
                
                subtrees[0] = nodes[1]?.leftChild
                subtrees[1] = nodes[1]?.rightChild
                subtrees[2] = nodes[2]?.rightChild
                subtrees[3] = nodes[0]?.rightChild
            } else {
                // left-right
                nodes[0] = node
                nodes[1] = node.leftChild
                nodes[2] = nodes[1]?.rightChild
                
                subtrees[0] = nodes[1]?.leftChild
                subtrees[1] = nodes[2]?.leftChild
                subtrees[2] = nodes[2]?.rightChild
                subtrees[3] = nodes[0]?.rightChild
            }
        } else if lrFactor < -1 {
            // right-left or right-right
            if heightDifference(node: node.rightChild) < 0 {
                // right-right
                nodes[1] = node
                nodes[2] = node.rightChild
                nodes[0] = nodes[2]?.rightChild
                
                subtrees[0] = nodes[1]?.leftChild
                subtrees[1] = nodes[2]?.leftChild
                subtrees[2] = nodes[0]?.leftChild
                subtrees[3] = nodes[0]?.rightChild
            } else {
                // right-left
                nodes[1] = node
                nodes[0] = node.rightChild
                nodes[2] = nodes[0]?.leftChild
                
                subtrees[0] = nodes[1]?.leftChild
                subtrees[1] = nodes[2]?.leftChild
                subtrees[2] = nodes[2]?.rightChild
                subtrees[3] = nodes[0]?.rightChild
            }
        } else {
            // Don't need to balance 'node', go for parent
            balance(node: node.parent)
            return
        }
        
        // nodes[2] is always the head
        
        if node.isRoot {
            root = nodes[2]
            root?.parent = nil
        } else if node.isLeftChild {
            nodeParent?.leftChild = nodes[2]
            nodes[2]?.parent = nodeParent
        } else if node.isRightChild {
            nodeParent?.rightChild = nodes[2]
            nodes[2]?.parent = nodeParent
        }
        
        nodes[2]?.leftChild = nodes[1]
        nodes[1]?.parent = nodes[2]
        nodes[2]?.rightChild = nodes[0]
        nodes[0]?.parent = nodes[2]
        
        nodes[1]?.leftChild = subtrees[0]
        subtrees[0]?.parent = nodes[1]
        nodes[1]?.rightChild = subtrees[1]
        subtrees[1]?.parent = nodes[1]
        
        nodes[0]?.leftChild = subtrees[2]
        subtrees[2]?.parent = nodes[0]
        nodes[0]?.rightChild = subtrees[3]
        subtrees[3]?.parent = nodes[0]
        
        updateHeightUpwards(node: nodes[1])    // Update height from left
        updateHeightUpwards(node: nodes[0])    // Update height from right
        
        balance(node: nodes[2]?.parent)
    }
    
    //MARK: - Delete
    
    //MARK: - Search
    public func search(value: T) -> T? {
        return search(value: value, node: root)?.data
    }
    
    private func search(value: T, node: Node?) -> Node? {
        if let node = node {
            if value == node.data {
                return node
            } else if value < node.data {
                return search(value: value, node: node.leftChild)
            } else {
                return search(value: value, node: node.rightChild)
            }
        }
        return nil
    }
    
    //MARK: - Traverse
    
    
    //MARK: - TreeNode
    private class TreeNode<T: Comparable> {
        typealias Node = TreeNode<T>
        
        private(set) var data: T
        var leftChild: Node?
        var rightChild: Node?
        var height: Int
        weak var parent: Node?
        
        init(key: T, leftChild: Node?, rightChild: Node?, parent: Node?, height: Int) {
            self.data = key
            self.leftChild = leftChild
            self.rightChild = rightChild
            self.parent = parent
            self.height = height
            
            self.leftChild?.parent = self
            self.rightChild?.parent = self
        }
        
        convenience init(key: T) {
            self.init(key: key, leftChild: nil, rightChild: nil, parent: nil, height: 1)
        }
        
        var isRoot: Bool {
            return parent == nil
        }
        
        var isLeaf: Bool {
            return rightChild == nil && leftChild == nil
        }
        
        var isLeftChild: Bool {
            return parent?.leftChild === self
        }
        
        var isRightChild: Bool {
            return parent?.rightChild === self
        }
    }
}
