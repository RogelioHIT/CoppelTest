//
//  TMDBMoviesPage.swift
//  CoppelTest
//
//  Created by Rogelio on 09/07/22.
//

import Foundation

struct TMDBMoviesPage: Codable {
    let page: Int
    let results: [Movie]
}
