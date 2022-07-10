//
//  Movie.swift
//  CoppelTest
//
//  Created by Rogelio on 08/07/22.
//

import Foundation

struct Movie: Codable {
    let poster_path: String
    let id: Int
    let vote_average: Float
    let overview: String
    let release_date: String
    let original_language: String
    let original_title: String
    let title: String
    let video: Bool
    let adult: Bool?
}
