//
//  main.swift
//  AVLTree
//
//  Created by Oleksiy on 28.03.2021.
//

import Foundation

let tree = AVLTree<Int>()
let elementsCount = 1000000

var startCalculationTime = Date().timeIntervalSinceReferenceDate

for _ in 0..<elementsCount {
    tree.insert(value: Int.random(in: -20...20))
}

print("Add \(elementsCount) elements ")
var endCalculationTime = Date().timeIntervalSinceReferenceDate
print("\(endCalculationTime-startCalculationTime) seconds")

print("\nSize: \(tree.size) ")

startCalculationTime = Date().timeIntervalSinceReferenceDate

let treeArray = tree.toArray()

print("\nToArray \(elementsCount) elements ")
endCalculationTime = Date().timeIntervalSinceReferenceDate
print("\(endCalculationTime-startCalculationTime) seconds")

startCalculationTime = Date().timeIntervalSinceReferenceDate

for i in treeArray{
    tree.delete(value: i)
}

print("\nRemove \(elementsCount) elements ")
endCalculationTime = Date().timeIntervalSinceReferenceDate
print("\(endCalculationTime-startCalculationTime) seconds")
