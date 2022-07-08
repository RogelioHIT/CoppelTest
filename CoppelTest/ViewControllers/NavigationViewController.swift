//
//  NavigationViewController.swift
//  CoppelTest
//
//  Created by Rogelio on 07/07/22.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let mainViewController = MainViewController()
        viewControllers = [mainViewController]
    }
    
}
