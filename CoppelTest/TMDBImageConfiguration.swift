//
//  TMDBImageConfiguration.swift
//  CoppelTest
//
//  Created by Rogelio on 08/07/22.
//

import Foundation

struct TMDBImageConfiguration: Codable {
    let base_url: String
    let secure_base_url: String
    let poster_sizes: [TMDBPosterSize]
    
    func getValidPosterSize(size: TMDBPosterSize) -> TMDBPosterSize {
        if poster_sizes.contains(where: { $0 == size }) {
            return size
        } else {
            return TMDBPosterSize.original
        }
    }
}
