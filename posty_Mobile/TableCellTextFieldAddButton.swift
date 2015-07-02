//
//  TableCellTextFieldButton.swift
//  posty_Mobile
//
//  Created by admin on 26.06.15.
//  Copyright (c) 2015 ben-hx. All rights reserved.
//

import UIKit

protocol TableCellTextFieldAddButtonDelegate {
    func tableCellTextFieldAddButtonDidClickButton(cell: TableCellTextFieldAddButton, sender: UIButton, textField: UITextField)
}

class TableCellTextFieldAddButton: UITableViewCell {
    var delegate: TableCellTextFieldAddButtonDelegate?
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func buttonClick(sender: UIButton) {
        delegate?.tableCellTextFieldAddButtonDidClickButton(self, sender: sender, textField: textField)
    }

    override func awakeFromNib() {
        textField?.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        textFieldDidChange(textField)
    }
    
    func textFieldDidChange(textField: UITextField) {
        button.enabled = textField.text != ""
    }
}
