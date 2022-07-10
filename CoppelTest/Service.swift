//
//  Service.swift
//  CoppelTest
//
//  Created by Rogelio on 07/07/22.
//

import Foundation

class Service {
    static let shared: Service = Service()
    private let serviceSession: URLSession!
    
    private init() {
        serviceSession = URLSession.shared
    }
    
    func getMovieList(type: MovieListType, completion: @escaping (TMDBMoviesPage?, AppError?) -> Void) {
        let endpointString: String!
        switch type {
        case .popular:
            endpointString = Endpoint.popularMovies.getURLString( appendAPIKey: true)
        case .topRated:
            endpointString = Endpoint.topRatedMovies.getURLString( appendAPIKey: true)
        case .upcoming:
            endpointString = Endpoint.upcomingMovies.getURLString( appendAPIKey: true)
        case .nowPlaying:
            endpointString = Endpoint.nowPlayingMovies.getURLString( appendAPIKey: true)
        }
        
        guard let endpointURL = URL(string: endpointString) else {
            completion(nil, .badRequest)
            return }
        
        serviceSession.dataTask(with: endpointURL){ data, resp, error in
            if error != nil {
                completion(nil, .badRequest)
                return
            }
            
            guard let data = data else {
                completion(nil, .noData)
                return
            }

            do {
                let response: TMDBMoviesPage = try JSONDecoder().decode(TMDBMoviesPage.self, from: data)
                completion(response, nil)
            } catch {
                print(error.localizedDescription)
                completion(nil, .decodingError)
            }
        }.resume()
    }
    
    func deleteSession(sessionId: String, completion: @escaping  (Bool) -> Void) {
        guard let endpointURL = URL(string: Endpoint.logout.getURLString( appendAPIKey: true)) else {
            completion(false)
            return }
        
        var request = URLRequest(url: endpointURL)
        request.httpMethod = Endpoint.logout.method

        serviceSession.dataTask(with: request) { data, resp, error in
            if error != nil {
                completion(false)
                return
            }
            
            guard data != nil else {
                completion(false)
                return
            }
            
            completion(true)
        }.resume()
    }
    
    
    func configuration(completion: @escaping (TMDBConfiguration?, AppError?) -> Void) {
        guard let endpointURL = URL(string: Endpoint.configuration.getURLString( appendAPIKey: true)) else {
            completion(nil, .badRequest)
            return }
        
        serviceSession.dataTask(with: endpointURL){ data, resp, error in
            if error != nil {
                completion(nil, .badRequest)
                return
            }
            
            guard let data = data else {
                completion(nil, .noData)
                return
            }

            do {
                let response: TMDBConfiguration = try JSONDecoder().decode(TMDBConfiguration.self, from: data)
                completion(response, nil)
            } catch {
                print(error.localizedDescription)
                completion(nil, .decodingError)
            }
        }.resume()
    }
    
    func requestToken(username: String, password: String, completion: @escaping  (TMDBTokenResponse?, AppError?) -> Void) {
        guard let endpointURL = URL(string: Endpoint.requestToken.getURLString( appendAPIKey: true)) else {
            completion(nil, .badRequest)
            return }
        serviceSession.dataTask(with: endpointURL){ data, resp, error in
            if error != nil {
                completion(nil, .badRequest)
                return
            }
            
            guard let data = data else {
                completion(nil, .noData)
                return
            }
            
            do {
                let response: TMDBTokenResponse = try JSONDecoder().decode(TMDBTokenResponse.self, from: data)
                completion(response, nil)
            } catch {
                completion(nil, .decodingError)
            }
        }.resume()
    }
    
    func getSessionId(token: String, completion: @escaping  (TMDBSessionResponse?, AppError?) -> Void) {
        guard let endpointURL = URL(string: Endpoint.sessionId.getURLString( appendAPIKey: true)) else {
            completion(nil, .badRequest)
            return }
        
        var request = URLRequest(url: endpointURL)
        request.httpMethod = Endpoint.sessionId.method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let bodyParams: [String: String] =  ["request_token": token]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: bodyParams)
        } catch {
            completion(nil, .badRequest)
            return
        }

        serviceSession.dataTask(with: request) { data, resp, error in
            if error != nil {
                completion(nil, .badRequest)
                return
            }
            
            guard let data = data else {
                completion(nil, .noData)
                return
            }
            
            do {
                let response: TMDBSessionResponse = try JSONDecoder().decode(TMDBSessionResponse.self, from: data)
                completion(response, nil)
            } catch {
                completion(nil, .decodingError)
            }
        }.resume()
    }
}
