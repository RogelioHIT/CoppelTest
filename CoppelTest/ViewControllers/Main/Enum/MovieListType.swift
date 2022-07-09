//
//  MovieListType.swift
//  CoppelTest
//
//  Created by Rogelio on 09/07/22.
//

import Foundation

enum MovieListType: CaseIterable {
    case popular
    case topRated
    case upcoming
    case nowPlaying
    
    func getSectionName() -> String {
        switch self {
        case .popular: return "Popular"
        case .topRated: return "Top Rated"
        case .upcoming: return "Upcoming"
        case .nowPlaying: return "Now Playing"
        }
    }
}
