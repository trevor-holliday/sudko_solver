//
//  Solver.swift
//  SudkoSolver
//
//  Created by Trevor Holliday on 5/21/20.
//  Copyright © 2020 Trevor Holliday. All rights reserved.
//

import Foundation

class Solver {
    @discardableResult
    static func bruteForce(_ board: Board, onNewBoardDescription: ((String) -> Void)? = nil) throws -> Board {
        var boardCopy = board
        boardCopy.reducePossibleValues(onNewBoardDescription: onNewBoardDescription)

        guard !boardCopy.isSolved else {
            return boardCopy
        }

        if let nextBoards = boardCopy.attemptToUpdateFirstUnsettledCell(onNewBoardDescription: onNewBoardDescription) {
            if let solvedBoard = nextBoards.first(where: {
                let forcedBoard = try? Solver.bruteForce($0, onNewBoardDescription: onNewBoardDescription)
                return forcedBoard?.isSolved ?? false
            }) {
                return solvedBoard
            }
        }

        throw FailedToSolveError()
    }
}

struct FailedToSolveError: Error {}
