//
//  Puzzles.swift
//  SudkoSolver
//
//  Created by Trevor Holliday on 5/26/20.
//  Copyright © 2020 Trevor Holliday. All rights reserved.
//

import Foundation

struct Puzzles {
    private static var one = [
        [nil, nil, nil, 2, 6, nil, 7, nil, 1],
        [6, 8, nil, nil, 7, nil, nil, 9, nil],
        [1, 9, nil, nil, nil, 4, 5, nil, nil],
        [8, 2, nil, 1, nil, nil, nil, 4, nil],
        [nil, nil, 4, 6, nil, 2, 9, nil, nil],
        [nil, 5, nil, nil, nil, 3, nil, 2, 8],
        [nil, nil, 9, 3, nil, nil, nil, 7, 4],
        [nil, 4, nil, nil, 5, nil, nil, 3, 6],
        [7, nil, 3, nil, 1, 8, nil, nil, nil]
    ]

    static func randomPuzzle() -> [[Int?]] {
        return one
    }
}
