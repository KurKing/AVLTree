//
//  main.swift
//  AVLTree
//
//  Created by Oleksiy on 28.03.2021.
//

import Foundation

let tree = AVLTree<Int>()

tree.insert(value: 5)
tree.traverse()

tree.insert(value: 4)
tree.traverse()

tree.insert(value: 3)
tree.traverse()

tree.insert(value: 2)
tree.traverse()

tree.insert(value: 1)
tree.traverse()

tree.delete(value: 2)
tree.traverse()

tree.delete(value: 6)
tree.traverse()

tree.insert(value: 1)
tree.traverse()

print(tree.search(value: 3))
print(tree.search(value: 10))
