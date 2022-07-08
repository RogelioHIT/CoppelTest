//
//  CoppelTextField.swift
//  CoppelTest
//
//  Created by Rogelio on 07/07/22.
//

import UIKit

class CoppelTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        styleTextField()
    }
    
    private func styleTextField() {
        backgroundColor = .white
        borderStyle = .none
        font = UIFont.systemFont(ofSize: 13)
        textColor = .black
        layer.cornerRadius = 4.0
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    let padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 5)
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
