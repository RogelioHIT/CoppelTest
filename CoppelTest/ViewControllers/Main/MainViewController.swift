//
//  MainViewController.swift
//  CoppelTest
//
//  Created by Rogelio on 07/07/22.
//

import UIKit
import ActivityIndicatorManager

class MainViewController: UIViewController {

    let fullNavBar: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "darkGray")
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
     
    let menuStackView: UIStackView = {
       let sv = UIStackView()
        sv.alignment = .center
        sv.distribution = .fillEqually
        sv.backgroundColor = UIColor(named: "buttonOff")
        return sv
    }()
    
    var menuOptions = [UIButton]()
    var currentSection: MovieListType!
    
    let collectionView: CoppelCollectionView = {
        let cv = CoppelCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.isHidden = true
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        configLayout()
        updateSessionConfiguration { config in
            guard let config = config else {
                print("No configuration available")
                DispatchQueue.main.async {
                    AIMActivityIndicatorManager.sharedInstance.shouldHideIndicator()
                }
                return
            }
            
            SessionManager.shared.updateConfiguration(config)
            DispatchQueue.main.async {
                AIMActivityIndicatorManager.sharedInstance.shouldHideIndicator()
                self.collectionView.isHidden = false
            }
        }
        
        changeSection(section: currentSection)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func configUI() {
        view.backgroundColor = UIColor(named: "darkGreen")
        navigationTitle.text = "MOVIES"
        profileButton.addTarget(self, action: #selector(showUserOptions), for: .touchUpInside)
        navBar.addSubview(profileButton)
        navBar.addSubview(navigationTitle)
        fullNavBar.addSubview(navBar)
        view.addSubview(fullNavBar)
        currentSection = .popular
        
        MovieListType.allCases.enumerated().forEach { (index, type) in
            let button = CoppelSelectableButton()
            button.tag = index
            button.setTitle(type.getSectionName(), for: .normal)
            button.addTarget(self, action: #selector(selectedSection), for: .touchUpInside)
            if currentSection == type {
                button.isSelected = true
            }
            self.menuOptions.append(button)
            menuStackView.addArrangedSubview(button)
        }
        view.addSubview(menuStackView)
        view.addSubview(collectionView)
        
        collectionView.collectionViewDelegate = self
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
        
        
        menuStackView.translatesAutoresizingMaskIntoConstraints = false
        menuStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        menuStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        menuStackView.topAnchor.constraint(equalTo: fullNavBar.bottomAnchor,  constant: 16.0).isActive = true
        menuStackView.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0).isActive = true
        view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor,  constant: 16.0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor,  constant: 0.0).isActive = true
        collectionView.topAnchor.constraint(equalTo: menuStackView.bottomAnchor,  constant: 16.0).isActive = true
    }
    
    func showProfile() {
        print("show profile")
    }
    
    func logOut() {
        print("Log out")
        guard let sessionId = SessionManager.shared.getSessionId() else {
            return
        }
        
        Service.shared.deleteSession(sessionId: sessionId) { result in
            if result {
                SessionManager.shared.deleteSessionId()
                print(UserDefaults.standard.dictionaryRepresentation().keys)
                DispatchQueue.main.async {
                    self.presentLogin()
                }
            }
        }
    }
    
    func presentLogin() {
        let scene = UIApplication.shared.connectedScenes.first
        if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
            sd.window?.rootViewController = LoginViewController()
            sd.window?.makeKeyAndVisible()
        }
    }
    
    func showDetail(movie: MovieViewModel) {
        let detailView = DetailViewController()
        detailView.movieId = movie.movieId
        detailView.modalPresentationStyle = .pageSheet
        detailView.modalTransitionStyle = .coverVertical
        self.present(detailView, animated: true)
    }
}

// MARK: Service
extension MainViewController {
    func updateSessionConfiguration(completion: @escaping (TMDBConfiguration?) -> Void) {
        AIMActivityIndicatorManager.sharedInstance.shouldShowIndicator()
        Service.shared.configuration { configuration, error in
            if error != nil {
                completion(nil)
                return
            }
            completion(configuration)
        }
    }
    
    func getMovieList(type: MovieListType, completion: @escaping ([MovieViewModel]?) -> Void) {
        AIMActivityIndicatorManager.sharedInstance.shouldShowIndicator()
        Service.shared.getMovieList(type: type, completion: { movies, error in
            if error != nil {
                completion(nil)
                return
            }
            guard let movies = movies?.results.map({MovieViewModel(with: $0)}) else {
                completion(nil)
                return
            }
            
            completion(movies)
        })
    }
}

// MARK: Actions
extension MainViewController {
    @objc private func showUserOptions() {
        let alertActionSheet = UIAlertController(title: "What do you want to do?", message: nil, preferredStyle: .actionSheet)
        alertActionSheet.addAction(UIAlertAction(title: "View Profile", style: .default, handler: { action in
            self.showProfile()
        }))
        alertActionSheet.addAction(UIAlertAction(title: "Log out", style: .destructive, handler: { action in
            self.logOut()
        }))
        alertActionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alertActionSheet, animated: true)
    }
    
    @objc private func selectedSection(sender: UIButton) {
        if sender.isSelected { return }
        _ = menuOptions.map { $0.isSelected = false }
        sender.isSelected = !sender.isSelected
        currentSection = MovieListType.allCases[sender.tag]
        changeSection(section: currentSection)
    }
    
    func changeSection(section: MovieListType) {
        AIMActivityIndicatorManager.sharedInstance.shouldShowIndicator()
        getMovieList(type: section) { movies in
            self.collectionView.movies = movies ?? []
            DispatchQueue.main.async {
                AIMActivityIndicatorManager.sharedInstance.forceHideIndicator()
                self.collectionView.setContentOffset(CGPoint(x:0,y:0), animated: false)
                self.collectionView.reloadData()
            }
        }
    }
}

// MARK: Collectionview delegate
extension MainViewController: CoppelCollectionViewDelegate {
    func selectedCell(movie: MovieViewModel) {
        showDetail(movie: movie)
    }
}
