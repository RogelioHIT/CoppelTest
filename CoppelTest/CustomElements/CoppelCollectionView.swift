//
//  CoppelCollectionView.swift
//  CoppelTest
//
//  Created by Rogelio on 08/07/22.
//

import UIKit

protocol CoppelCollectionViewDelegate: AnyObject {
    func selectedCell(movie: MovieViewModel)
}

class CoppelCollectionView: UICollectionView {
    
    var movieCellId = "MovieCollectionViewCell"
    var movies = [MovieViewModel]()
    
    weak var collectionViewDelegate: CoppelCollectionViewDelegate?

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        dataSource = self
        delegate = self
        
        configCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configCollectionView() {
        self.backgroundColor = UIColor.clear
        self.backgroundView = UIView(frame: CGRect.zero)
        let cellNib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        self.register(cellNib, forCellWithReuseIdentifier: movieCellId)
    }
}

extension CoppelCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModelForCell = movies[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCellId, for: indexPath)
        if let cell = cell as? MovieCollectionViewCell {
            cell.config(with: viewModelForCell)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewModelForCell = movies[indexPath.item]
        if let delegate = self.collectionViewDelegate {
            delegate.selectedCell(movie: viewModelForCell)
        }
    }
}

extension CoppelCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        // aspect ratio of the designed cell
        let aspectRatio: CGFloat = 62/121
        let space: CGFloat = 16.0 // space left
        let width: CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: width, height: width / aspectRatio)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16.0
    }
    
    
}
