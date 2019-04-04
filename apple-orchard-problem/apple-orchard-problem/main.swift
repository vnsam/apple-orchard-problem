//
//  main.swift
//  Codility
//
//  Created by Vignesh Narayanasamy on 03/04/19.
//  Copyright © 2019 Vignesh Narayanasamy. All rights reserved.
//

import Foundation

print("Hello, World!")

public func solution(_ A : inout [Int], _ K : Int, _ L : Int) -> Int {
    var trees = A

    guard K != L else {
        return -1 // early return
    }

    var kCollectionsOfTress = [[Int]]()
    var lCollectionsOfTress = [[Int]]()

    var startIndex = 0
    var tempArray: [Int] = trees.dropLast(trees.count - K)


    // K - done
    while tempArray.count == K {
        kCollectionsOfTress.append(tempArray)
        startIndex += 1
        let leadingTrimmedArray = trees.dropFirst(startIndex)
        if leadingTrimmedArray.count >= K {
            tempArray = leadingTrimmedArray.dropLast(leadingTrimmedArray.count - K)
        } else {
            tempArray = []
        }
    }

    var kLastSum = kCollectionsOfTress.first!.reduce(0, +)
    var kTrees = [[Int]]()
    var lLeftTrees = [Int]()
    var removeIndex = 0

    for i in 0 ..< kCollectionsOfTress.count {
        let collection = kCollectionsOfTress[i]

        let kSum = collection.reduce(0, +)

        if kSum > kLastSum {
            kLastSum = kSum
            kTrees.removeAll()
            kTrees.append(collection)
            removeIndex = i
        } else {
            lLeftTrees.append(contentsOf: collection)
        }
    }

    trees.removeFirst(removeIndex + K)
    print("Trees after removing: \(trees)")

    // Reset - temp array, start index
    startIndex = 0
    let uniqueLeftTreesArray = trees

    tempArray = uniqueLeftTreesArray.dropLast(uniqueLeftTreesArray.count - L)

    while tempArray.count == L {
        lCollectionsOfTress.append(tempArray)
        startIndex += 1
        let leadingTrimmedArry = uniqueLeftTreesArray.dropFirst(startIndex)
        if leadingTrimmedArry.count >= L {
            tempArray = leadingTrimmedArry.dropLast(leadingTrimmedArry.count - L)
        } else {
            tempArray = []
        }
    }

    var lLastSum = lCollectionsOfTress.first!.reduce(0, +)

    for selectedTrees in lCollectionsOfTress {
        let sum = selectedTrees.reduce(0, +)
        if sum > lLastSum {
            lLastSum = sum
        }
    }

    print("L Last Sum: \(lLastSum)")

    print("K collection of trees: \(kCollectionsOfTress)\n")

    print("L collection of trees: \(lCollectionsOfTress)\n")

    return kLastSum + lLastSum
}

var tress = [6,1,4,6,3,2,7,4]
let total = solution(&tress, 3, 2)

print("Total max of Apples: \(total)")

var secondTrees = [9, 12, 1, 3, 7, 9, 17, 25, 32, 1, 6, 5, 4, 3]
let secondTotal = solution(&secondTrees, 4, 5)

print("Total max of Apples in Second Orchard: \(secondTotal)")
