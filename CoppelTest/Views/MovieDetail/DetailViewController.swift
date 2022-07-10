//
//  DetailViewController.swift
//  CoppelTest
//
//  Created by Rogelio on 09/07/22.
//

import UIKit
import ActivityIndicatorManager

class DetailViewController: UIViewController {
    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var originalNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var isAdultMovie: UIImageView!

    
    var movieId: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dismissGesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        dismissGesture.delegate = self
        view.addGestureRecognizer(dismissGesture)
        
        configUI()
        getMovieInfo(id: movieId) { movie in
            DispatchQueue.main.async {
                AIMActivityIndicatorManager.sharedInstance.shouldHideIndicator()
                
                if let movie = movie {
                    self.config(with: movie)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func config(with movie: MovieViewModel) {
        nameLabel.text = movie.movieTitle
        originalNameLabel.text = movie.movieOriginalTitle
        posterImage.sd_setImage(with: movie.moviePosterURL)
        dateLabel.text = movie.releaseDate
        descriptionLabel.text = movie.overview
        scoreLabel.text = movie.voteAverage
        isAdultMovie.isHidden = !movie.isAdultMovie
    }
    
    func configUI() {
        posterImage.addShadow()
    }
}

// MARK: Gesture recognizer delegate
extension DetailViewController {
    func getMovieInfo(id: Int, completion: @escaping (MovieViewModel?) -> Void) {
        AIMActivityIndicatorManager.sharedInstance.shouldShowIndicator()
        Service.shared.getMovie(id: id, completion: { movie, error in
            if error != nil {
                completion(nil)
                return
            }
            
            guard let movie = movie else {
                completion(nil)
                return
            }
            
            completion(MovieViewModel(with: movie))
        })
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
