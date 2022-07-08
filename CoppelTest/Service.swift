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
    
    func requestToken(username: String, password: String, completion: @escaping  (RequestTokenResponse?, AppError?) -> Void) {
        guard let endpointURL = URL(string: Endpoint.requestToken.urlString) else {
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
                let response: RequestTokenResponse = try JSONDecoder().decode(RequestTokenResponse.self, from: data)
                completion(response, nil)
            } catch {
                completion(nil, .decodingError)
            }
        }.resume()
    }
    
    func getSessionId(token: String, completion: @escaping  (RequestSessionResponse?, AppError?) -> Void) {
        guard let endpointURL = URL(string: Endpoint.sessionId.urlString) else {
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
                let response: RequestSessionResponse = try JSONDecoder().decode(RequestSessionResponse.self, from: data)
                completion(response, nil)
            } catch {
                completion(nil, .decodingError)
            }
        }.resume()
    }
}
