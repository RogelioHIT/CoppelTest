//
//  LoginViewModel.swift
//  CoppelTest
//
//  Created by Rogelio on 07/07/22.
//

import Foundation

struct LoginViewModel {
    var userName: String!
    var userPassword: String!
        
    init(userName: String?, userPassword: String?) {
        self.userName = userName ?? ""
        self.userPassword = userPassword ?? ""
    }
    
    func isInformationValid() -> Bool {
        guard let name = userName, !name.isEmpty, let password = userPassword, !password.isEmpty else {
            return false
        }
        
        if name.isValidEmail() {
            return false
        }
        
        return true
    }
}

// MARK: Services
extension LoginViewModel {
    func requestToken(completion: @escaping (String?, AppError?) -> Void) {
        Service.shared.requestToken(username: userName, password: userPassword) { response, error in
            guard let resp = response, error == nil else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            DispatchQueue.main.async {
                completion(resp.request_token, nil)
            }
        }
    }
    
    func requestSessionId(token: String, completion: @escaping (String?, AppError?) -> Void) {
        Service.shared.getSessionId(token: token) { response, error in
            guard let resp = response, error == nil else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            DispatchQueue.main.async {
                completion(resp.session_id, nil)
            }
        }
    }
}

