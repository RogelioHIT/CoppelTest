//
//  MovieCollectionViewCell.swift
//  CoppelTest
//
//  Created by Rogelio on 08/07/22.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        setupUI()
    }
    
    private func setupUI() {
        self.posterImage.addRoundedCorners(radius: 25.0)
        self.contentView.addRoundedCorners(radius: 25.0)
        scoreLabel.isUserInteractionEnabled = false
    }
    
    func config(with movie: MovieViewModel) {
        nameLabel.text = movie.movieName
        posterImage.sd_setImage(with: movie.moviePosterURL)
        dateLabel.text = movie.releaseDate
        descriptionLabel.text = movie.overview
        scoreLabel.text = movie.voteAverage
    }

}
