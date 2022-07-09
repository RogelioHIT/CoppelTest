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
        return movie.original_name.capitalized
    }
    
    var moviePosterURL: URL? {
        return createURLFor(poster: movie.poster_path)
    }
    
    var backdropPath: URL? {
        return createURLFor(poster: movie.backdrop_path)
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
    
    static func getDummyModel() -> MovieViewModel {
        let randomNumber = Int.random(in: 1..<100)
        let dummyMovie = Movie(poster_path: "/7q448EVOnuE3gVAx24krzO7SNXM.jpg", backdrop_path: "/wcKFYIiVDvRURrzglV9kGu7fpfY.jpg", id: 31917, vote_average: 10.0, overview: "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.", release_date: "2016-08-03", original_language: "en", original_name: "Dummy #\(randomNumber)", video: false)
        return MovieViewModel(with: dummyMovie)
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

