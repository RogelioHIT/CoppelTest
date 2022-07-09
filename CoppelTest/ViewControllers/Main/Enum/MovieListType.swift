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
    case onTv
    case airingToday
    
    func getSectionName() -> String {
        switch self {
        case .popular: return "Popular"
        case .topRated: return "Top Rated"
        case .onTv: return "On TV"
        case .airingToday: return "Airing Today"
        }
    }
}
