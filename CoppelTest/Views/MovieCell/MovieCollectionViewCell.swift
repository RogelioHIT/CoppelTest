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
    @IBOutlet weak var scoreLabel: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.posterImage.addRoundedCorners(radius: 25.0)
        self.contentView.addRoundedCorners(radius: 25.0)
    }
    
    func config(with movie: MovieViewModel) {
        nameLabel.text = movie.movieName
    }

}
