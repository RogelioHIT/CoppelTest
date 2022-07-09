//
//  CoppelSelectableButton.swift
//  CoppelTest
//
//  Created by Rogelio on 09/07/22.
//

import UIKit

class CoppelSelectableButton: UIButton {
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? UIColor(named: "buttonOn")! : UIColor.clear
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTitleColor(.white, for: .selected)
        setTitleColor(.lightGray, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .bold)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        layer.cornerRadius = rect.height/4
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
