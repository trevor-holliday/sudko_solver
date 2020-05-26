//
//  Board.swift
//  SudkoSolver
//
//  Created by Trevor Holliday on 5/22/20.
//  Copyright © 2020 Trevor Holliday. All rights reserved.
//

import Foundation

struct Board: CustomStringConvertible {
    private var rows: [[Cell]]

    init(startingPuzzle: [[Int?]]) {
        rows = startingPuzzle.map {
            $0.map { number in
                if let number = number {
                    return Cell(number)
                } else {
                    return Cell()
                }
            }
        }
    }

    var description: String {
        return rows.map { row in
            return "[ \(row.map { $0.description}.joined(separator: " ")) ]\n"
        }
        .joined()
    }

    var isSolved: Bool {
        guard Array(rows.joined()).allSatisfy({$0.isSettled}) else {
            return false
        }

        let allRowsEqual45 = rows.allSatisfy { row in
            return row.sum() == 45
        }

        let allColumnsEqual45 = (0..<9).allSatisfy { index in
            return columnFor(index).sum() == 45
        }

        return allRowsEqual45 && allColumnsEqual45
    }

    var boardValues: [[Int?]] {
        return self.rows.map { row in
            row.map { cell in
                cell.isSettled ? cell.values.first : nil
            }
        }
    }

    mutating func reducePossibleValues(onNewBoardDescription: ((String) -> Void)? = nil){
        while !isSolved {
            var foundSomething = false

            rows.enumerated().forEach { (rowIndex, row) in
                row.enumerated().forEach { (columnIndex, cell) in
                    guard !cell.isSettled else {
                        return
                    }

                    let possibleValues = cell.values.filter {
                        canInsert(newValue: $0, rowIndex: rowIndex, columnIndex: columnIndex)
                    }

                    guard !possibleValues.isEmpty else { return }

                    if possibleValues.count == 1 {
                        foundSomething = true
                    }

                    try? update(rowIndex: rowIndex, columnIndex: columnIndex, values: possibleValues, onNewBoardDescription: onNewBoardDescription)
                }
            }

            guard foundSomething else { return }
        }
    }

    mutating func attemptToUpdateFirstUnsettledCell(onNewBoardDescription: ((String) -> Void)? = nil) -> [Board]?{
        if let rowIndex = rows.firstIndex(where: { $0.contains { !$0.isSettled } }),
            let columnIndex = rows[rowIndex].firstIndex(where: {  !$0.isSettled }) {
            let cell = rows[rowIndex][columnIndex]

            return cell.values.compactMap { possibleValue in
                var copy = self
                try? copy.update(rowIndex: rowIndex, columnIndex: columnIndex, values: [possibleValue], onNewBoardDescription: onNewBoardDescription)
                return copy
            }
        }
        return nil
    }

}

extension Board {
    // MARK: Private Methods
    private init(puzzle: [[Cell]]) {
        self.rows = puzzle
    }

    private func regionFor(rowIndex: Int, columnIndex: Int) -> [Cell] {
        let regionColumnIndex = columnIndex / 3
        let regionRowIndex = rowIndex / 3
        var value = [Cell]()
        Array((0..<3)).forEach { rowOffSet in
            let rIndex = (regionRowIndex * 3 + rowOffSet)
            let cIndex = (regionColumnIndex*3..<regionColumnIndex*3+3)
            value.append(contentsOf: Array(rows[rIndex][cIndex]))
        }
        return value
    }

    private func columnFor(_ index: Int) -> [Cell] {
        return rows.map {
            return $0[index]
        }
    }

    private func canInsert(newValue: Int, rowIndex: Int, columnIndex: Int) -> Bool {
        return !rows[rowIndex].contains(.init(newValue))
            && !columnFor(columnIndex).contains(.init(newValue))
            && !regionFor(rowIndex: rowIndex, columnIndex: columnIndex).contains(.init(newValue))
    }

    private mutating func update(rowIndex: Int, columnIndex: Int, values: [Int], onNewBoardDescription: ((String) -> Void)? = nil) throws {
        if values.count == 1,
            let value = values.first,
            !canInsert(newValue: value, rowIndex: rowIndex, columnIndex: columnIndex) {
            throw ConsistencyError()
        }

        rows[rowIndex][columnIndex] = Cell(values: values)

        onNewBoardDescription?(self.description)
    }
}

struct ConsistencyError: Error {}

