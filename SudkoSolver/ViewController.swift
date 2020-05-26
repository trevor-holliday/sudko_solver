//
//  ViewController.swift
//  SudkoSolver
//
//  Created by Trevor Holliday on 5/21/20.
//  Copyright © 2020 Trevor Holliday. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var boardCollectionView: UICollectionView!

    @IBAction private func onSolveTapped(_ sender: UIButton) {
        let startingBoard = Board(startingPuzzle: puzzle)
        if let solvedBoard = try? Solver.bruteForce(startingBoard) {
            puzzle = solvedBoard.boardValues
            boardCollectionView.reloadData()
        }
    }

    private var puzzle = Puzzles.randomPuzzle()
}

extension ViewController: UICollectionViewDataSource {
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 9
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BoardCell", for: indexPath) as! BoardCell
        cell.textField.text = {
            if let settledNumber = puzzle[indexPath.row][indexPath.section] {
                return String(settledNumber)
            }
            return "-"
        }()
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 0.5
        cell.onNumberChange = { [weak self] in
            self?.puzzle[indexPath.row][indexPath.section] = $0
        }
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        let width = (screenSize.width - 40) / 9
        return CGSize(width: width, height: width)
    }
}

extension ViewController: UICollectionViewDelegate {
    // MARK: UICollectionViewDelegate
}
