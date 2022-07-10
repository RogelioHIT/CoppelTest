//
//  MovieViewModel.swift
//  CoppelTest
//
//  Created by Rogelio on 08/07/22.
//

import Foundation
import UIKit
import SDWebImage

struct MovieViewModel {
    
    var movie: Movie!
    
    var movieName: String {
        return movie.original_title.capitalized
    }
    
    var moviePosterURL: URL? {
        return createURLFor(poster: movie.poster_path)
    }
    
    var releaseDate: String {
        let releaseDate = formatDate(date: movie.release_date)
        return releaseDate
    }
    
    var voteAverage: String {
        return "★ \(movie.vote_average)"
    }
    
    var overview: String {
        return movie.overview.capitalized
    }

    init(with movie: Movie){
        self.movie = movie
    }
    
    private func formatDate(date:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: date) {
            return "\(date.appDateFormat)".capitalized
        }
        return "-"
    }
}

// MARK: Extensions
extension MovieViewModel {
    private func createURLFor(poster: String) -> URL? {
        guard let imagesConfiguration = SessionManager.shared.getImagesConfiguration() else {
            return nil
        }
        let posterSize = imagesConfiguration.getValidPosterSize(size: TMDBPosterSize.w500)
        let urlString = "\(imagesConfiguration.secure_base_url + posterSize.rawValue)\(poster)"
        return URL(string: urlString)
    }
}

// MARK: Services
extension MovieViewModel {
    func requestMovies(completion: @escaping (String?, AppError?) -> Void) {

    }
}

