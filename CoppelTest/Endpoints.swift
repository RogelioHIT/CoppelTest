//
//  Endpoints.swift
//  CoppelTest
//
//  Created by Rogelio on 07/07/22.
//

import Foundation

enum Endpoint {
    static let API_KEY: String = "5650d15b02b02e76cc7f3fe5863b98c4"
    case movieDetail
    case popularMovies
    case topRatedMovies
    case upcomingMovies
    case nowPlayingMovies
    case requestToken
    case authenticate
    case sessionId
    case configuration
    case logout
    
    func getURLString(id: Int? = nil, parameters: [String: QueryParam] = [:], appendAPIKey:Bool) -> String {
        var baseEndpoint: String = ""
        switch self {
        case .movieDetail:
            baseEndpoint = "https://api.themoviedb.org/3/movie/\(id!)"
        case .popularMovies:
            baseEndpoint = "https://api.themoviedb.org/3/movie/top_rated"
        case .topRatedMovies:
            baseEndpoint = "https://api.themoviedb.org/3/movie/popular"
        case .upcomingMovies:
            baseEndpoint = "https://api.themoviedb.org/3/movie/upcoming"
        case .nowPlayingMovies:
            baseEndpoint = "https://api.themoviedb.org/3/movie/now_playing"
        case .configuration:
            baseEndpoint = "https://api.themoviedb.org/3/configuration"
        case .authenticate:
            baseEndpoint = "https://www.themoviedb.org/authenticate/"
        case .requestToken:
            baseEndpoint = "https://api.themoviedb.org/3/authentication/token/new"
        case .sessionId:
            baseEndpoint = "https://api.themoviedb.org/3/authentication/session/new"
        case .logout:
            baseEndpoint = "https://api.themoviedb.org/3/authentication/session"
        }
        
        if appendAPIKey {
            baseEndpoint += "?api_key=\(Endpoint.API_KEY)"
        }else {
            baseEndpoint += "?"
        }
        
        parameters.keys.forEach { key in
            let value = parameters[key]
            baseEndpoint += "\(key)=\(value)&"
        }
        
        if baseEndpoint.last == "&" || baseEndpoint.last == "?" {
            baseEndpoint =  String(baseEndpoint.dropLast())
        }
        
        return baseEndpoint
    }
    
    var method: String? {
        get {
            switch self {
            case .sessionId:
                return "POST"
            case .logout:
                return "DELETE"
            default:
                return "GET"
            }
        }
    }
    
}
