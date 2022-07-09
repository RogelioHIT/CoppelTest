//
//  ProfileView.swift
//  CoppelTest
//
//  Created by Rogelio on 09/07/22.
//

import UIKit

class ProfileView: UIView {
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var moviesCollectionView: CoppelCollectionView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
