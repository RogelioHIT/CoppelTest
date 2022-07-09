//
//  RequestSessionResponse.swift
//  CoppelTest
//
//  Created by Rogelio on 07/07/22.
//

import Foundation

struct TMDBSessionResponse: Decodable {
    let success: Bool!
    let session_id: String!
}
