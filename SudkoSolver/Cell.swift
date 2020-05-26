//
//  Cell.swift
//  SudkoSolver
//
//  Created by Trevor Holliday on 5/22/20.
//  Copyright © 2020 Trevor Holliday. All rights reserved.
//

struct Cell: Equatable, CustomStringConvertible {
    let values: [Int]

    var isSettled: Bool {
        values.count == 1
    }

    var description: String {
        isSettled ? String(values.first!) : "-"
    }

    init(_ settled: Int) {
        self.values = [settled]
    }

    init(values: [Int]) {
        self.values = values
    }

    /// Returns a cell containing values 1...9
    init() {
        self.values = Array(1...9)
    }
}
