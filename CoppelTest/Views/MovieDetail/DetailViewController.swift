//
//  DetailViewController.swift
//  CoppelTest
//
//  Created by Rogelio on 09/07/22.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var movie: MovieViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dismissGesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        dismissGesture.delegate = self
        view.addGestureRecognizer(dismissGesture)
        
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        config(with: movie)
    }
    
    func config(with movie: MovieViewModel) {
        nameLabel.text = movie.movieName
        posterImage.sd_setImage(with: movie.moviePosterURL)
        dateLabel.text = movie.releaseDate
        descriptionLabel.text = movie.overview
        scoreLabel.text = movie.voteAverage
    }
    
    func configUI() {
        posterImage.addShadow()
//        gradientView.setGradientBackground(from: UIColor(named: "darkGreen")!, to: .clear)
    }
}

// MARK: Gesture recognizer delegate
extension DetailViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view != modalView
    }
}


// MARK: Actions
extension DetailViewController {
    @objc private func dismissView(){
        print("Dismiss the view")
        dismiss(animated: true)
    }
}
