//
//  AVLTree.swift
//  AVLTree
//
//  Created by Oleksiy on 28.03.2021.
//

import Foundation

class AVLTree<T:Comparable> {
    
    //MARK: - Calculators
    private func calcBalance(node: Node?) -> Int {
        if let node = node {
            return calcHeight(node: node.leftChild) - calcHeight(node: node.rightChild)
        }
        return 0
    }
    
    private func calcHeight(node: Node?) -> Int {
        if let node = node {
            return node.height
        }
        return -1
    }
    
    //MARK: - Node class
    private class Node: Comparable {
        
        private(set) var data: T
        
        var height = 0
        var leftChild: Node?
        var rightChild: Node?
        
        init(data: T) {
            self.data = data
        }
        
        static func < (lhs: AVLTree<T>.Node, rhs: AVLTree<T>.Node) -> Bool {
            return true
        }
        
        static func == (lhs: AVLTree<T>.Node, rhs: AVLTree<T>.Node) -> Bool {
            return true
        }
    }
}
