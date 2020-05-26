//
//  BoardCell.swift
//  SudkoSolver
//
//  Created by Trevor Holliday on 5/26/20.
//  Copyright © 2020 Trevor Holliday. All rights reserved.
//

import UIKit

class BoardCell: UICollectionViewCell {
    @IBOutlet weak var textField: UITextField! {
        didSet {
            addToolBar()
        }
    }

    var onNumberChange: ((Int) -> Void)?
}

extension BoardCell {
    // MARK: Private Methods
    private func addToolBar() {
        let numberToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        numberToolbar.barStyle = .default
        numberToolbar.items = [
        UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissNumberPad))]
        numberToolbar.sizeToFit()
        textField.inputAccessoryView = numberToolbar
    }

    @objc
    private func dismissNumberPad() {
        textField.resignFirstResponder()
    }
}

extension BoardCell: UITextFieldDelegate {
    // MARK: UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch string {
        case "0", "":
            return false
        default:
            if let newNumber = Int(string) {
                textField.text = string
                onNumberChange?(newNumber)
            }
            return false
        }
    }
}
