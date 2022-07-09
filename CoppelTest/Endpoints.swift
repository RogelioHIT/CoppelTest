//
//  Endpoints.swift
//  CoppelTest
//
//  Created by Rogelio on 07/07/22.
//

import Foundation

enum Endpoint {
    static let API_KEY: String = "5650d15b02b02e76cc7f3fe5863b98c4"
    case requestToken
    case authenticate
    case sessionId
    case configuration

    var urlString: String {
        get {
            switch self {
            case .configuration:
                return "https://api.themoviedb.org/3/configuration?api_key=\(Endpoint.API_KEY)"
            case .authenticate:
                return "https://www.themoviedb.org/authenticate/"
            case .requestToken:
                return "https://api.themoviedb.org/3/authentication/token/new?api_key=\(Endpoint.API_KEY)"
            case .sessionId:
                return "https://api.themoviedb.org/3/authentication/session/new?api_key=\(Endpoint.API_KEY)"
            }
        }
    }
    
    var method: String? {
        get {
            switch self {
            case .requestToken, .configuration:
                return "GET"
            case .sessionId:
                return "POST"
            default:
                return nil
            }
        }
    }
    
}
