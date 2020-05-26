//
//  Array+Extension.swift
//  SudkoSolver
//
//  Created by Trevor Holliday on 5/26/20.
//  Copyright © 2020 Trevor Holliday. All rights reserved.
//

import Foundation

extension Array where Element == Int {
    func sum() -> Int {
        return reduce(0) { (pastResult, nextValue) -> Int in
            return pastResult + nextValue
        }
    }
}

extension Array where Element == Cell {
    func sum() -> Int {
        return reduce(0) { (pastResult, nextCell) -> Int in
            return pastResult + nextCell.values.sum()
        }
    }
}
