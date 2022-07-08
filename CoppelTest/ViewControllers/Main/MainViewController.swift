//
//  MainViewController.swift
//  CoppelTest
//
//  Created by Rogelio on 07/07/22.
//

import UIKit

class MainViewController: UIViewController {

    let fullNavBar: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.darkGray
        view.layer.cornerRadius = 15.0
        view.layer.masksToBounds = true
        return view
    }()
    
    let navBar: UIView = {
        let view = UIView()
        return view
    }()
    
    let navigationTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    let profileButton: UIButton = {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .bold, scale: .large)
        let profileImage = UIImage(systemName: "person.circle.fill", withConfiguration: largeConfig)
        let button = UIButton()
        button.setImage(profileImage, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    let collectionView: CoppelCollectionView = {
        let cv = CoppelCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        configLayout()
        addActions()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func configUI() {
        if let navigationController = self.navigationController {
            navigationController.isNavigationBarHidden = true
        }
        
        view.backgroundColor = AppColors.darkBlue
        navigationTitle.text = "TV SHOWS"
        profileButton.addTarget(self, action: #selector(showProfile), for: .touchUpInside)
        navBar.addSubview(profileButton)
        navBar.addSubview(navigationTitle)
        fullNavBar.addSubview(navBar)
        view.addSubview(fullNavBar)
        
        view.addSubview(collectionView)
    }
    
    private func configLayout() {
        let safeArea = view.layoutMarginsGuide
        
        fullNavBar.translatesAutoresizingMaskIntoConstraints = false
        fullNavBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        fullNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        fullNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
 
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        navBar.bottomAnchor.constraint(equalTo: fullNavBar.bottomAnchor).isActive = true
        navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        navBar.heightAnchor.constraint(equalToConstant: 60.0).isActive = true

        profileButton.translatesAutoresizingMaskIntoConstraints = false
        profileButton.heightAnchor.constraint(equalTo: navBar.heightAnchor).isActive = true
        profileButton.widthAnchor.constraint(equalTo: navBar.heightAnchor).isActive = true
        profileButton.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: 8.0).isActive = true
        
        navigationTitle.translatesAutoresizingMaskIntoConstraints = false
        navigationTitle.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 16).isActive = true
        navigationTitle.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: 16).isActive = true
        navigationTitle.centerYAnchor.constraint(equalTo: navBar.centerYAnchor).isActive = true
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0).isActive = true
        view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor,  constant: 16.0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo:  view.bottomAnchor,  constant: 0.0).isActive = true
        collectionView.topAnchor.constraint(equalTo:  fullNavBar.bottomAnchor,  constant: 32.0).isActive = true
    }
    
    private func addActions() {

    }

}

// MARK: Actions
extension MainViewController {
    @objc private func showProfile() {
        print("show profile")
    }
}
